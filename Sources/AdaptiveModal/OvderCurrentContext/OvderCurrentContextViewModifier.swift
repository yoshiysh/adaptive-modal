//
//  OvderCurrentContextViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/03.
//

import SwiftUI

struct OverCurrentContextViewModifier<T: View>: ViewModifier {
    @Binding private var isPresented: Bool
    private let willDismiss: (() -> Void)?
    private let onDismiss: (() -> Void)?
    private let body: () -> T

    init(
        isPresented: Binding<Bool>,
        willDismiss: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        body: @escaping () -> T
    ) {
        _isPresented = isPresented
        self.willDismiss = willDismiss
        self.onDismiss = onDismiss
        self.body = body
    }

    func body(content: Content) -> some View {        
        content
            .background(
                OvderCurrentContextRepresentable(
                    isPresented: $isPresented,
                    willDismiss: { willDismiss?() },
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
        willDismiss: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(OverCurrentContextViewModifier(
            isPresented: isPresented,
            willDismiss: willDismiss,
            onDismiss: onDismiss,
            body: content
        ))
    }
}
