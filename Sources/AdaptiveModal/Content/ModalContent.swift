//
//  ModalContent.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/05.
//

import SwiftUI

protocol ModalContentDelegate {
    func updateBackground(opacity: Double)
}

struct ModalContent: View {
    @Environment(\.presentationMode) @Binding var presentationMode
    
    @State var cancelable = ModalInteractiveDismissDisabled.defaultValue
    @State var draggable = ModalDraggableDisabled.defaultValue

    @State var opacity = 0.0
    @State var translation: CGSize = .zero
    @State var contentHeight: Double = .zero
    @State var safeAreaInsetBottom: Double = .zero

    var delegate: ModalContentDelegate?

    private let onDismiss: () -> Void
    private let content: AnyView

    private let fraction: CGFloat = 0.95
    private let maxOpacity = 0.6
    private var translatedHeight: Double { max(contentHeight + safeAreaInsetBottom, 100) * 1.1 }

    var body: some View {
        contentView()
            .onAnimationCompleted(for: translation.height) {
                if translation.height >= translatedHeight {
                    dismiss()
                }
            } onValueChanged: { value in
                if !translation.height.isZero {
                    opacity = min(
                        opacity,
                        ((contentHeight - value) / contentHeight) * maxOpacity
                    )
                }
            }
            .onChange(of: opacity) { value in
                delegate?.updateBackground(opacity: opacity)
            }
            .onPreferenceChange(ModalInteractiveDismissDisabled.self) { value in
                cancelable = !value
            }
            .onPreferenceChange(ModalDraggableDisabled.self) { value in
                draggable = !value
            }
    }

    init(
        onDismiss: @escaping () -> Void,
        content: @escaping () -> some View
    ) {
        self.onDismiss = onDismiss
        self.content = AnyView(content())
    }
}

private extension ModalContent {
    func contentView() -> some View {
        ZStack {
            Color.black
                .opacity(0.0001)
                .ignoresSafeArea()
                .onTapGesture {
                    if cancelable {
                        dismiss()
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
            }
        }
    }
    
    @ViewBuilder
    func modalView() -> some View {
        if draggable {
            modalContent()
                .draggableBackground(cancelable: cancelable) {
                    dismiss()
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

    func dismiss() {
        if !presentationMode.isPresented { return }
        onDismiss()
    }

    func modalContent() -> some View {
        content.frame(maxWidth: .infinity)
    }

    func maxHeight() -> CGFloat {
        UIScreen.main.bounds.height * fraction
    }

    func minHeight() -> CGFloat {
        UIScreen.main.bounds.height - maxHeight()
    }
}
