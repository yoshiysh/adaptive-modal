//
//  RoundedRectangleShape.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

struct RoundedRectangleShape: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(cornerRadius: CGFloat, corners: UIRectCorner) {
        radius = cornerRadius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
