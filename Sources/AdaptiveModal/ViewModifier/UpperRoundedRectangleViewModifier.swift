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
    private let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangleShape(
                    cornerRadius: cornerRadius,
                    corners: [.topLeft, .topRight]
                )
                .offset(offset)
                .fill(backgroundColor)
                .ignoresSafeArea()
            )
    }

    init(
        offset: Binding<CGSize>,
        cornerRadius: CGFloat,
        backgroundColor: Color
    ) {
        _offset = offset
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }
}

// MARK: View Extension
extension View {
    @MainActor
    func upperRoundedBackground(
        offset: Binding<CGSize> = .constant(.zero),
        cornerRadius: CGFloat = 16,
        backgroundColor: Color
    ) -> some View {
        modifier(UpperRoundedRectangleViewModifier(
            offset: offset, 
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor
        ))
    }
}
