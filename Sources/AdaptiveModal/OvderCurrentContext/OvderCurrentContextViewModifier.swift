//
//  OvderCurrentContextViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/03.
//

import SwiftUI

struct OverCurrentContextViewModifier<T: View>: ViewModifier {
    @Binding private var isPresented: Bool
    private let onDismiss: (() -> Void)?
    private let body: () -> T

    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        body: @escaping () -> T
    ) {
        _isPresented = isPresented
        self.onDismiss = onDismiss
        self.body = body
    }

    func body(content: Content) -> some View {        
        content
            .background(
                OvderCurrentContextRepresentable(
                    isPresented: $isPresented,
                    onDismiss: { onDismiss?() },
                    content: body
                )
            )
    }
}

// MARK: - View Extension
extension View {
    func overCurrentContext(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(OverCurrentContextViewModifier(
            isPresented: isPresented,
            onDismiss: onDismiss,
            body: content
        ))
    }
}
