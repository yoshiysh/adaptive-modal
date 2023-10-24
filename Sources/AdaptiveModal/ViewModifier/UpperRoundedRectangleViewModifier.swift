//
//  UpperRoundedRectangleViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/04.
//

import SwiftUI

struct UpperRoundedRectangleViewModifier: ViewModifier {
    @Binding private var offset: CGSize
    private let cornerRadius: CGFloat
    
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

    init(
        offset: Binding<CGSize>,
        cornerRadius: CGFloat
    ) {
        _offset = offset
        self.cornerRadius = cornerRadius
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
            offset: offset, 
            cornerRadius: cornerRadius
        ))
    }
}
