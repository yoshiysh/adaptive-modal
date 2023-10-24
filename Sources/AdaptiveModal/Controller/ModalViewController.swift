//
//  ModalViewController.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/24.
//

import SwiftUI

class ModalViewController: UIViewController {}

// MARK: UIViewControllerTransitioningDelegate
extension ModalViewController: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        ModalPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}
