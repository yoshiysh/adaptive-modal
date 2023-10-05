//
//  AdaptiveModalViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/03.
//

import SwiftUI

extension AdaptiveModalViewModifier {
    @MainActor
    func onDismissAnimation() {
        withAnimation(.easeOut) {
            translation = CGSize(
                width: .zero,
                height: translatedHeight
            )
        }
    }

    @MainActor
    func onEndDismissAnimation() {
        isPresenteContainer = false
        isPresented = false
        onDismiss?()
    }

    @MainActor
    func fullScreenCoverView() -> some View {
        fullScreenCoverContent()
            .onAnimationCompleted(for: translation.height) {
                if isPresentedContnet && translation.height >= translatedHeight {
                    isPresentedContnet = false
                    onEndDismissAnimation()
                }
            } onValueChanged: { value in
                if !translation.height.isZero {
                    opacity = min(
                        opacity,
                        ((contentHeight - value) / contentHeight) * maxOpacity
                    )
                }
            }
            .onAppear {
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
                    
                    modalView()
                        .contentHeight(
                            contentHeight: { contentHeight = $0 },
                            safeAreaInsetBottom: { safeAreaInsetBottom = $0 }
                        )
                        .offset(translation)
                        .layoutPriority(1)
                }
                .transition(.move(edge: .bottom).animation(.smooth))
            }
        }
    }

    @MainActor
    @ViewBuilder
    func modalView() -> some View {
        if draggable {
            modalContent()
                .draggableBackground(cancelable: cancelable) {
                    if isPresentedContnet {
                        isPresentedContnet = false
                        onEndDismissAnimation()
                    }
                } onTranslationHeightChanged: { value in
                    opacity = min(
                        maxOpacity,
                        ((translatedHeight - value) / translatedHeight) * maxOpacity
                    )
                }
        } else {
            modalContent()
                .upperRoundedBackground()
        }
    }
    
    @MainActor
    func modalContent() -> some View {
        body().frame(maxWidth: .infinity)
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
