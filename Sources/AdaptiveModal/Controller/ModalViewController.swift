//
//  ModalViewController.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/24.
//

import SwiftUI

class ModalViewController: UIViewController {
    private var modalPresentationController: ModalPresentationController?
}

// MARK: - UIViewControllerTransitioningDelegate
extension ModalViewController: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let controller = ModalPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
        modalPresentationController = controller
        return controller
    }
}

// MARK: - ModalContentDelegate
extension ModalViewController: ModalContentDelegate {
    func updateBackground(opacity: Double) {
        modalPresentationController?.updateBackground(opacity: opacity)
    }
}
