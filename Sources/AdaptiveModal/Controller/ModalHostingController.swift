//
//  ModalHostingController.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/24.
//

import SwiftUI

class ModalHostingController<Content: View>: UIHostingController<Content> {
    override init(rootView: Content) {
        super.init(rootView: rootView)
        modalPresentationStyle = .custom
        view.backgroundColor = .clear
    }

    @MainActor
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
