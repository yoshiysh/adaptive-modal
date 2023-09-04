//
//  AdaptivePanel.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

struct AdaptivePanel<Content: View>: View, @unchecked Sendable {
    @State var disableAnimations = true
    @State var isPresenteContainer = false
    @State var isPresentedContnet = false
    @State var opacity = 0.0

    @Binding var isPresented: Bool
    let targetView: AnyView
    var content: () -> Content
    let onDismiss: (() -> Void)?
    let draggable: Bool
    let cancelable: Bool
    
    let fraction: CGFloat = 0.95
    let minOpacity = 0.0
    let maxOpacity = 0.6

    var body: some View {
        targetView
            .fullScreenCover(
                isPresented: $isPresenteContainer,
                content: fullScreenCoverView
            )
            .onChange(of: isPresented) { state in
                if state {
                    isPresenteContainer = true
                } else {
                    onDismissAnimation()
                }
            }
            .transaction { transaction in
                transaction.disablesAnimations = disableAnimations
            }
    }

    init(
        targetView: some View,
        isPresented: Binding<Bool>,
        draggable: Bool,
        cancelable: Bool,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> Content
    ) {
        self.targetView = AnyView(targetView)
        _isPresented = isPresented
        self.draggable = draggable
        self.cancelable = cancelable
        self.onDismiss = onDismiss
        self.content = content
    }
}
