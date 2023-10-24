//
//  ModalContent.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/05.
//

import SwiftUI

struct ModalContent<Content: View>: View {
    @Binding var isPresented: Bool
    @State var opacity = 0.0
    @State var translation: CGSize = .zero
    @State var contentHeight: Double = .zero
    @State var safeAreaInsetBottom: Double = .zero

    let content: () -> Content
    let onDismiss: () -> Void
    let draggable: Bool
    let cancelable: Bool

    let fraction: CGFloat = 0.95
    let minOpacity = 0.0
    let maxOpacity = 0.6
    var translatedHeight: Double { max(contentHeight + safeAreaInsetBottom, 100) * 1.1 }

    var body: some View {
        contentView()
            .onAnimationCompleted(for: translation.height) {
                if translation.height >= translatedHeight {
                    onEndDismissAnimation()
                }
            } onValueChanged: { value in
                if !translation.height.isZero {
                    opacity = min(
                        opacity,
                        ((contentHeight - value) / contentHeight) * maxOpacity
                    )
                }
            }
            .onAppear {
                translation = .zero

                withAnimation(.easeOut) {
                    opacity = maxOpacity
                }
            }
            .onChange(of: isPresented) { value in
                if value { return }
                onDismissAnimation()
            }
    }

    init(
        isPresented: Binding<Bool>,
        draggable: Bool,
        cancelable: Bool,
        onDismiss: @escaping () -> Void,
        content: @escaping () -> Content
    ) {
        _isPresented = isPresented
        self.draggable = draggable
        self.cancelable = cancelable
        self.onDismiss = onDismiss
        self.content = content
    }
}

private extension ModalContent {
    @MainActor
    func contentView() -> some View {
        ZStack {
            Color.black
                .opacity(0.01)
                .ignoresSafeArea()
                .onTapGesture {
                    if cancelable {
                        onDismissAnimation()
                    }
                }

            VStack {
                Spacer()
                    .frame(minHeight: minHeight())

                modalView()
                    .contentHeight(
                        contentHeight: { contentHeight = $0 },
                        safeAreaInsetBottom: { safeAreaInsetBottom = $0 }
                    )
                    .offset(translation)
                    .layoutPriority(1)
                    .transition(.move(edge: .bottom).animation(.smooth))
            }
        }
    }
    
    @MainActor
    @ViewBuilder
    func modalView() -> some View {
        if draggable {
            modalContent()
                .draggableBackground(cancelable: cancelable) {
                    onEndDismissAnimation()
                } onTranslationHeightChanged: { value in
                    opacity = min(
                        maxOpacity,
                        ((translatedHeight - value) / translatedHeight) * maxOpacity
                    )
                }
        } else {
            modalContent()
                .upperRoundedBackground()
        }
    }

    @MainActor
    func onDismissAnimation() {
        withAnimation(.easeOut) {
            translation = CGSize(
                width: .zero,
                height: translatedHeight
            )
        }
    }

    @MainActor
    func onEndDismissAnimation() {
        if isPresented {
            onDismiss()
        }
    }

    @MainActor
    func modalContent() -> some View {
        content().frame(maxWidth: .infinity)
    }

    @MainActor
    func maxHeight() -> CGFloat {
        UIScreen.main.bounds.height * fraction
    }

    @MainActor
    func minHeight() -> CGFloat {
        UIScreen.main.bounds.height - maxHeight()
    }
}
