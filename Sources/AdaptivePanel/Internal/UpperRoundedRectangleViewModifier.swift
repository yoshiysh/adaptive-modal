//
//  UpperRoundedRectangleViewModifier.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/04.
//

import SwiftUI

struct UpperRoundedRectangleViewModifier: ViewModifier {
    let cornerRadius: CGFloat
    @Binding var offset: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangleShape(
                    cornerRadius: cornerRadius,
                    corners: [.topLeft, .topRight]
                )
                .offset(offset)
                .fill(Color(UIColor.secondarySystemBackground))
                .ignoresSafeArea()
            )
    }
}

// MARK: View Extension
extension View {
    @MainActor
    func upperRoundedBackground(
        cornerRadius: CGFloat = 16,
        offset: Binding<CGSize> = .constant(.zero)
    ) -> some View {
        modifier(UpperRoundedRectangleViewModifier(
            cornerRadius: cornerRadius,
            offset: offset
        ))
    }
}
