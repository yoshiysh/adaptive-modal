//
//  RoundedRectangleShape.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

struct RoundedRectangleShape: Shape {
    private let radius: CGFloat
    private let corners: UIRectCorner

    init(
        cornerRadius: CGFloat,
        corners: UIRectCorner
    ) {
        radius = cornerRadius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: .init(
                x: rect.origin.x,
                y: rect.origin.y,
                width: rect.width,
                height: rect.height + 1000
            ),
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
