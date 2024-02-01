//
//  DraggableViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/04.
//

import SwiftUI

struct DraggableBackgroundViewModifier: ViewModifier {
    @State private var translation: CGSize = .zero
    @State private var contentHeight: Double = .zero
    @State private var safeAreaInsetBottom: Double = .zero

    private let cancelable: Bool
    private let onDismiss: () -> Void
    private let onTranslationHeightChanged: (Double) -> Void
    private var translatedHeight: Double { max(contentHeight + safeAreaInsetBottom, 100) * 1.1 }

    func body(content: Content) -> some View {
        content
            .contentHeight(
                contentHeight: { contentHeight = $0 },
                safeAreaInsetBottom: { safeAreaInsetBottom = $0 }
            )
            .offset(translation.height > 0 ? translation : .zero)
            .upperRoundedBackground(offset: $translation)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        translation = gesture.calculationTranslation()
                    }
                    .onEnded { gesture in
                        if cancelable && gesture.requireDismiss(contentHeight: contentHeight) {
                            withAnimation(.easeOut) {
                                translation = CGSize(
                                    width: .zero,
                                    height: translatedHeight
                                )
                            }
                        } else {
                            withAnimation(.interpolatingSpring) {
                                translation = .zero
                            }
                        }
                    }
            )
            .onAnimationCompleted(for: translation.height) {
                if translation.height >= translatedHeight {
                    onDismiss()
                }
            } onValueChanged: { value in
                onTranslationHeightChanged(value)
            }
    }
    
    init(
        cancelable: Bool,
        onDismiss: @escaping () -> Void,
        onTranslationHeightChanged: @escaping (Double) -> Void
    ) {
        self.cancelable = cancelable
        self.onDismiss = onDismiss
        self.onTranslationHeightChanged = onTranslationHeightChanged
    }
}

// MARK: View Extension
extension View {
    func draggableBackground(
        cancelable: Bool,
        onDismiss: @escaping () -> Void,
        onTranslationHeightChanged: @escaping (Double) -> Void
    ) -> some View {
        modifier(DraggableBackgroundViewModifier(
            cancelable: cancelable,
            onDismiss: onDismiss,
            onTranslationHeightChanged: onTranslationHeightChanged
        ))
    }
}

// MARK: Private DragGesture.Value Extension
private extension DragGesture.Value {
    func calculationTranslation() -> CGSize {
        if translation.height < 0.0 {
            CGSize(
                width: .zero,
                height: -sqrt(-translation.height)
            )
        } else {
            CGSize(
                width: .zero,
                height: translation.height
            )
        }
    }

    func requireDismiss(contentHeight: Double) -> Bool {
        velocity.height > 2000 || translation.height > contentHeight * 0.5
    }
}
