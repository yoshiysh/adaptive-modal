//
//  ModalViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/03.
//

import SwiftUI

struct ModalViewModifier<Body: View>: ViewModifier {
    private let onDismiss: (() -> Void)?
    private let body: () -> Body

    init(
        onDismiss: (() -> Void)? = nil,
        body: @escaping () -> Body
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
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(ModalViewModifier(
            onDismiss: onDismiss,
            body: content
        ))
    }
}
