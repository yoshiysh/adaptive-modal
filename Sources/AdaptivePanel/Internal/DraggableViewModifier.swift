//
//  DraggableViewModifier.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/04.
//

import SwiftUI

struct DraggableViewModifier: ViewModifier {
    @State var translation: CGSize = .zero
    
    let cancelable: Bool
    let onDismiss: () -> Void

    func body(content: Content) -> some View {
        content
            .offset(translation)
            .backgroundUpperRounded(offset: $translation)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        translation = if gesture.translation.height < 0.0 {
                            CGSize(
                                width: .zero,
                                height: -sqrt(-gesture.translation.height)
                            )
                        } else {
                            CGSize(
                                width: .zero,
                                height: gesture.translation.height
                            )
                        }
                    }
                    .onEnded { gesture in
                        if gesture.velocity.height > 2000 && cancelable {
                            withAnimation(.interactiveSpring) {
                                translation = CGSize(
                                    width: translation.width,
                                    height: .greatestFiniteMagnitude
                                )
                            }
                            onDismiss()
                        } else {
                            withAnimation(.interactiveSpring) {
                                translation = .zero
                            }
                        }
                    }
            )
    }
    
    init(
        cancelable: Bool,
        onDismiss: @escaping () -> Void
    ) {
        self.cancelable = cancelable
        self.onDismiss = onDismiss
    }
}

extension View {
    @MainActor
    func draggable(
        cancelable: Bool,
        onDismiss: @escaping () -> Void
    ) -> some View {
        modifier(DraggableViewModifier(
            cancelable: cancelable, 
            onDismiss: onDismiss
        ))
    }
}
