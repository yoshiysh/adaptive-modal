//
//  AdaptiveModalViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

struct AdaptiveModalViewModifier<Body: View>: ViewModifier {
    @Binding var isPresented: Bool
    @State var isPresentedContainer = false
    let body: () -> Body
    let onDismiss: (() -> Void)?
    let draggable: Bool
    let cancelable: Bool

    init(
        isPresented: Binding<Bool>,
        draggable: Bool,
        cancelable: Bool,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> Body
    ) {
        _isPresented = isPresented
        self.draggable = draggable
        self.cancelable = cancelable
        self.onDismiss = onDismiss
        self.body = content
    }

    func body(content: Content) -> some View {
        content
            .overCurrentContext(
                isPresented: $isPresentedContainer,
                onDismiss: {
                    isPresented = false
                    onDismiss?()
                }
            ) {
                AdaptiveModalContent(
                    isPresented: $isPresented,
                    draggable: draggable,
                    cancelable: cancelable,
                    onDismiss: { isPresentedContainer = false },
                    content: body
                )
            }
            .onChange(of: isPresented) { value in
                if !isPresentedContainer {
                    isPresentedContainer = value
                }
            }
    }
}
