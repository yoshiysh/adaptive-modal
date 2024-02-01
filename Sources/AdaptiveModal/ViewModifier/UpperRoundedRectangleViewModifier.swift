//
//  UpperRoundedRectangleViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/04.
//

import SwiftUI

struct UpperRoundedRectangleViewModifier: ViewModifier {
    @State private var backgroundColor: Color = {
        guard let defaultValue = ModalBackgroundColor.defaultValue else {
            fatalError("Require Default Value")
        }
        return defaultValue
    }()

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
                .fill(backgroundColor)
                .ignoresSafeArea()
            )
            .onPreferenceChange(ModalBackgroundColor.self) { value in
                if let value {
                    backgroundColor = value
                }
            }
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
    func upperRoundedBackground(
        offset: Binding<CGSize> = .constant(.zero),
        cornerRadius: CGFloat = 16
    ) -> some View {
        modifier(UpperRoundedRectangleViewModifier(
            offset: offset, 
            cornerRadius: cornerRadius
        ))
    }
}
