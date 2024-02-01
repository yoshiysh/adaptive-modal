//
//  AdaptiveModalViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

struct AdaptiveModalViewModifier<Body: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let body: () -> Body
    let onDismiss: (() -> Void)?

    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> Body
    ) {
        _isPresented = isPresented
        self.onDismiss = onDismiss
        self.body = content
    }

    func body(content: Content) -> some View {
        content
            .modal(isPresented: $isPresented) {
                isPresented = false
                onDismiss?()
            } content: {
                ModalContent(content: body)
            }
    }
}
