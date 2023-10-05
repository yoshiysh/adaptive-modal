//
//  AdaptiveModalViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

struct AdaptiveModalViewModifier<Body: View>: ViewModifier {
    @State var isPresenteContainer = false
    @State var isPresentedContnet = false
    @State var opacity = 0.0
    @State var translation: CGSize = .zero
    @State var contentHeight: Double = .zero
    @State var safeAreaInsetBottom: Double = .zero

    @Binding var isPresented: Bool
    var body: () -> Body
    let onDismiss: (() -> Void)?
    let draggable: Bool
    let cancelable: Bool

    let fraction: CGFloat = 0.95
    let minOpacity = 0.0
    let maxOpacity = 0.6
    var translatedHeight: Double { max(contentHeight + safeAreaInsetBottom, 100) * 1.1 }

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
                isPresented: $isPresented,
                willDismiss: {},
                onDismiss: {
                    isPresented = false
                    onDismiss?()
                },
                content: fullScreenCoverView
            )
    }
}
