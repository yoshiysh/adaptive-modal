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
        content: @escaping () -> A,
        onDismiss: (() -> Void)? = nil
    ) {
        self.targetView = targetView
        _isPresented = isPresented
        self.content = content()
        self.onDismiss = onDismiss
    }
}

// MARK: Private Function {
private extension AdaptivePanel {
    func onDismissAnimation() {
        withAnimation(.easeIn) {
            opacity = minOpacity
            isPresentedContnet = false
        }
    }

    func onEndDismissAnimation() {
        disableAnimations = true
        isPresenteContainer = false
        isPresented = false
        onDismiss?()
    }
    
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
