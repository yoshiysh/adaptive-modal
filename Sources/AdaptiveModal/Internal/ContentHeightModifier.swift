//
//  ContentHeightModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/05.
//

import SwiftUI

struct ContentHeightModifier: ViewModifier {
    let contentHeight: (Double) -> Void

    func body(content: Content) -> some View {
        contentView(content)
    }

    init(contentHeight: @escaping (Double) -> Void) {
        self.contentHeight = contentHeight
    }
}

// MARK: View Extension
extension View {
    @MainActor
    func contentHeight(_ contentHeight: @escaping (Double) -> Void) -> some View {
        modifier(ContentHeightModifier(contentHeight: contentHeight))
    }
}

private extension ContentHeightModifier {
    @MainActor
    func contentView(_ content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    DispatchQueue.main.async {
                        contentHeight(proxy.size.height)
                    }
                    return Color.clear
                }
            )
    }
}
