//
//  ModalViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/03.
//

import SwiftUI

struct ModalViewModifier: ViewModifier {
    @Binding private var isPresented: Bool
    private let onDismiss: (() -> Void)?
    private let body: () -> ModalContent

    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        body: @escaping () -> ModalContent
    ) {
        _isPresented = isPresented
        self.onDismiss = onDismiss
        self.body = body
    }

    func body(content: Content) -> some View {        
        content
            .background(
                ModalRepresentable(
                    isPresented: $isPresented,
                    onDismiss: { onDismiss?() },
                    content: body
                )
            )
    }
}

// MARK: - View Extension
extension View {
    func modal(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> ModalContent
    ) -> some View {
        modifier(ModalViewModifier(
            isPresented: isPresented,
            onDismiss: onDismiss,
            body: content
        ))
    }
}
