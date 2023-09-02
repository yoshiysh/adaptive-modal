//
//  AdaptivePanelInternal.swift
//  AdaptivePanel
//
//  Created by yoshi on 2023/09/02.
//

import SwiftUI

struct AdaptivePanel<A, T>: View, @unchecked Sendable where A: View, T: View {
    @State private var disableAnimations = true
    @State private var isPresenteContainer = false
    @State private var isPresentedContnet = false
    @State private var opacity = 0.0

    @Binding private var isPresented: Bool
    private let targetView: T
    private let content: A
    private let onDismiss: (() -> Void)?
    
    private let minOpacity = 0.0
    private let maxOpacity = 0.6

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
        targetView: T,
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> A
    ) {
        self.targetView = targetView
        _isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content()

    }
}

// MARK: Private Function {
private extension AdaptivePanel {
    @MainActor
    func onDismissAnimation() {
        withAnimation(.easeIn) {
            opacity = minOpacity
            isPresentedContnet = false
        }
    }

    @MainActor
    func onEndDismissAnimation() {
        disableAnimations = true
        isPresenteContainer = false
        isPresented = false
        onDismiss?()
    }
    
    @MainActor
    func fullScreenCoverView() -> some View {
        fullScreenCoverContent()
            .background(BackgroundView(backgroundColor: .clear))
            .onAnimationCompleted(for: opacity) {
                if opacity == minOpacity {
                    onEndDismissAnimation()
                }
            }
            .onAppear {
                disableAnimations = false
                opacity = minOpacity
                isPresentedContnet = false

                withAnimation(.easeIn) {
                    opacity = maxOpacity
                    isPresentedContnet = true
                }
            }
    }
    
    @MainActor
    func fullScreenCoverContent() -> some View {
        ZStack {
            Color.black.opacity(opacity)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismissAnimation()
                }

            VStack {
                Spacer()
                if isPresentedContnet {
                    panelView()
                }
            }
        }
    }
    
    @MainActor
    func panelView() -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangleShape(
                    cornerRadius: 16,
                    corners: [.topLeft, .topRight]
                )
                .fill(Color(UIColor.secondarySystemBackground))
                .ignoresSafeArea()
            )
            .transition(.move(edge: .bottom))
    }
}
