//
//  ModalViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/03.
//

import SwiftUI

struct ModalViewModifier: ViewModifier {
    private let onDismiss: (() -> Void)?
    private let body: () -> ModalContent

    init(
        onDismiss: (() -> Void)? = nil,
        body: @escaping () -> ModalContent
    ) {
        self.onDismiss = onDismiss
        self.body = body
    }

    func body(content: Content) -> some View {        
        content
            .background(
                ModalRepresentable(
                    onDismiss: { onDismiss?() },
                    content: body
                )
            )
    }
}

// MARK: - View Extension
extension View {
    func modal(
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> ModalContent
    ) -> some View {
        modifier(ModalViewModifier(
            onDismiss: onDismiss,
            body: content
        ))
    }
}
