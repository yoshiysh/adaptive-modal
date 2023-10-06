//
//  AdaptiveModalContent.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/05.
//

import SwiftUI

struct AdaptiveModalContent<Content: View>: View {
    @State var isPresentedContnet = false
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
                if isPresentedContnet && translation.height >= translatedHeight {
                    isPresentedContnet = false
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
                    isPresentedContnet = true
                }
            }
    }

    init(
        draggable: Bool,
        cancelable: Bool,
        onDismiss: @escaping () -> Void,
        content: @escaping () -> Content
    ) {
        self.draggable = draggable
        self.cancelable = cancelable
        self.onDismiss = onDismiss
        self.content = content
    }
}

private extension AdaptiveModalContent {
    @MainActor
    func contentView() -> some View {
        ZStack {
            Color.black
                .opacity(opacity)
                .ignoresSafeArea()
                .onTapGesture {
                    if cancelable {
                        onDismissAnimation()
                    }
                }

            if isPresentedContnet {
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
                }
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
                    if isPresentedContnet {
                        isPresentedContnet = false
                        onEndDismissAnimation()
                    }
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
        onDismiss()
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
