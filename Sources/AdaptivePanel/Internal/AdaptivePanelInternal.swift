//
//  AdaptivePanelInternal.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/03.
//

import SwiftUI

extension AdaptivePanel {
    @MainActor
    func onDismissAnimation() {
        withAnimation(.easeIn) {
            translation = CGSize(
                width: translation.width,
                height: translatedHeight
            )
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
            .onAnimationCompleted(for: translation.height) {
                if translation.height == translatedHeight {
                    isPresentedContnet = false
                    onEndDismissAnimation()
                }
            } onValueChanged: { value in
                if !translation.height.isZero {
                    opacity = min(
                        opacity,
                        ((translatedHeight - value) / translatedHeight) * maxOpacity
                    )
                }
            }
            .onAppear {
                disableAnimations = false
                translation = .zero

                withAnimation(.easeOut) {
                    opacity = maxOpacity
                    isPresentedContnet = true
                }
            }
    }

    @MainActor
    func fullScreenCoverContent() -> some View {
        ZStack {
            Color.black
                .opacity(opacity)
                .ignoresSafeArea()
                .onTapGesture {
                    if cancelable {
                        onDismissAnimation()
                    }
                }
            
            if isPresentedContnet {
                VStack {
                    Spacer()
                        .frame(minHeight: minHeight())
                    
                    panelView()
                        .contentHeight { contentHeight = $0 }
                        .offset(translation)
                        .layoutPriority(1)
                }
                .transition(.move(edge: .bottom).animation(.smooth))
            }
        }
    }

    @MainActor
    @ViewBuilder
    func panelView() -> some View {
        if draggable {
            panelContent()
                .draggableBackground(cancelable: cancelable) {
                    onDismissAnimation()
                } onTranslationHeightChanged: { value in
                    opacity = min(
                        maxOpacity,
                        ((translatedHeight - value) / translatedHeight) * maxOpacity
                    )
                }
        } else {
            panelContent()
                .upperRoundedBackground()
        }
    }
    
    @MainActor
    func panelContent() -> some View {
        content().frame(maxWidth: .infinity)
    }

    @MainActor
    func maxHeight() -> CGFloat {
        UIScreen.main.bounds.height * fraction
    }

    @MainActor
    func minHeight() -> CGFloat {
        UIScreen.main.bounds.height - maxHeight()
    }
}
