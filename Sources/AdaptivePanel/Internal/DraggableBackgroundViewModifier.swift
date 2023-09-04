//
//  DraggableViewModifier.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/04.
//

import SwiftUI

struct DraggableBackgroundViewModifier: ViewModifier {
    @State private var translation: CGSize = .zero
    @State private var contentHeight: Double = .zero

    private let cancelable: Bool
    private let onDismiss: () -> Void
    private let onTranslationHeightChanged: (Double) -> Void
    private var translatedHeight: Double { contentHeight * 1.1 }

    func body(content: Content) -> some View {
        content
            .contentHeight { contentHeight = $0 }
            .offset(translation.height > 0 ? translation : .zero)
            .upperRoundedBackground(offset: $translation)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        translation = gesture.calculationTranslation()
                    }
                    .onEnded { gesture in
                        if cancelable && gesture.requireDismiss(contentHeight: contentHeight) {
                            withAnimation(.interactiveSpring) {
                                translation = CGSize(
                                    width: translation.width,
                                    height: translatedHeight
                                )
                            }
                        } else {
                            withAnimation(.interactiveSpring) {
                                translation = .zero
                            }
                        }
                    }
            )
            .onChange(of: translation.height) { value in
                onTranslationHeightChanged(value)
            }
            .onAnimationCompleted(for: translation.height) {
                if translation.height == translatedHeight {
                    onDismiss()
                }
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
    @MainActor
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

// MARK: Private Extension
private extension DraggableBackgroundViewModifier {
    @MainActor
    func contentView(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    DispatchQueue.main.async {
                        contentHeight = proxy.size.height
                    }
                    return Color.clear
                }
            )
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
