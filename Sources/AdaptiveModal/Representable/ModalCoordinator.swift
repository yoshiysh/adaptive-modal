//
//  ModalCoordinator.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/24.
//

import SwiftUI

class ModalCoordinator: NSObject {
    private let parent: ModalRepresentable

    init(_ parent: ModalRepresentable) {
        self.parent = parent
    }
}

// MARK: - ModalContentDelegate
extension ModalCoordinator: ModalContentDelegate {
    func updateBackground(opacity: Double) {
        if !parent.isPresented { return }
        parent.viewController.updateBackground(opacity: opacity)
    }

    func dismiss() {
        if !parent.isPresented { return }
        parent.dismiss(parent.viewController)
    }
}
