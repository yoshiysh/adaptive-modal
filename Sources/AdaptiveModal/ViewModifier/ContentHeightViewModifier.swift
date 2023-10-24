//
//  ContentHeightViewModifier.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/05.
//

import SwiftUI

struct ContentHeightViewModifier: ViewModifier {
    let contentHeight: (Double) -> Void
    let safeAreaInsetBottom: (Double) -> Void

    func body(content: Content) -> some View {
        contentView(content)
    }

    init(
        contentHeight: @escaping (Double) -> Void,
        safeAreaInsetBottom: @escaping (Double) -> Void
    ) {
        self.contentHeight = contentHeight
        self.safeAreaInsetBottom = safeAreaInsetBottom
    }
}

// MARK: View Extension
extension View {
    @MainActor
    func contentHeight(
        contentHeight: @escaping (Double) -> Void,
        safeAreaInsetBottom: @escaping (Double) -> Void
    ) -> some View {
        modifier(ContentHeightViewModifier(
            contentHeight: contentHeight,
            safeAreaInsetBottom: safeAreaInsetBottom
        ))
    }
}

private extension ContentHeightViewModifier {
    @MainActor
    func contentView(_ content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    DispatchQueue.main.async {
                        contentHeight(proxy.size.height)
                        safeAreaInsetBottom(proxy.safeAreaInsets.bottom)
                    }
                    return Color.clear
                }
            )
    }
}
