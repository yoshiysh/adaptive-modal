//
//  ModalPresentationController.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/24.
//

import SwiftUI

class ModalPresentationController: UIPresentationController {
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func presentationTransitionWillBegin() {
        guard let containerView else { return }

        dimmedView.alpha = 0
        containerView.insertSubview(dimmedView, at: 0)

        NSLayoutConstraint.activate([
            dimmedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dimmedView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

        presentedViewController.transitionCoordinator?.animate { [weak self] _ in
            self?.dimmedView.alpha = 0.6
        }
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate { [weak self] _ in
            self?.dimmedView.alpha = 0
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmedView.removeFromSuperview()
        }
    }
}

extension ModalPresentationController {
    func updateBackground(opacity: Double) {
        dimmedView.alpha = opacity
    }
}
