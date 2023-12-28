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
    let draggable: Bool
    let cancelable: Bool
    let backgroundColor: Color

    init(
        isPresented: Binding<Bool>,
        draggable: Bool,
        cancelable: Bool,
        backgroundColor: Color?,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> Body
    ) {
        _isPresented = isPresented
        self.draggable = draggable
        self.cancelable = cancelable
        self.backgroundColor = backgroundColor ?? Color(UIColor.secondarySystemBackground)
        self.onDismiss = onDismiss
        self.body = content
    }

    func body(content: Content) -> some View {
        content
            .modal(
                isPresented: $isPresented,
                onDismiss: {
                    isPresented = false
                    onDismiss?()
                }
            ) {
                ModalContent(
                    draggable: draggable,
                    cancelable: cancelable,
                    backgroundColor: backgroundColor,
                    content: body
                )
            }
    }
}
