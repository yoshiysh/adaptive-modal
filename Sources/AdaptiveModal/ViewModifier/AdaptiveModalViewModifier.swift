//
//  AdaptiveModalViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

struct AdaptiveModalViewModifier<Body: View>: ViewModifier {
    @Environment(\.isModalPresented) @Binding var isPresented
    
    let body: () -> Body
    let onDismiss: (() -> Void)?

    init(
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> Body
    ) {
        self.onDismiss = onDismiss
        self.body = content
    }

    func body(content: Content) -> some View {
        content
            .modal {
                isPresented = false
                onDismiss?()
            } content: {
                ModalContent(
                    onDismiss: {
                        isPresented = false
                    },
                    content: body
                )
            }
    }
}
