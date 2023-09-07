//
//  BackgroundView.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

struct BackgroundView: UIViewRepresentable {
    private let backgroundColor: UIColor

    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }

    func makeUIView(context: Context) -> some UIView {
        InnerView(backgroundColor: backgroundColor)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // no-op
    }
}

// MARK: InnerView
private extension BackgroundView {
    class InnerView: UIView {
        private let bgColor: UIColor

        init(backgroundColor: UIColor) {
            self.bgColor = backgroundColor
            super.init(frame: .zero)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func didMoveToWindow() {
            super.didMoveToWindow()
            superview?.superview?.backgroundColor = bgColor
        }
    }
}
