//
//  ModalRepresentable.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/02.
//

import SwiftUI

struct ModalRepresentable<Content: View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = PresentationViewController

    @Binding private var isPresented: Bool
    private let onDismiss: () -> Void
    private let content: () -> Content

    init(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void,
        content: @escaping () -> Content
    ) {
        _isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content
    }

    func makeUIViewController(context: Context) -> UIViewControllerType {
        PresentationViewController()
    }

    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        let isHostingControllerPresented = uiViewController.presentedViewController is UIHostingController<Content>

        if isPresented {
            if isHostingControllerPresented { return }

            let hostingController = HostingController(rootView: content())
            hostingController.transitioningDelegate = uiViewController
            DispatchQueue.main.async {
                uiViewController.present(hostingController, animated: true)
            }
        } else {
            if !isHostingControllerPresented { return }

            DispatchQueue.main.async {
                uiViewController.dismiss(animated: true) {
                    onDismiss()
                }
            }
        }
    }
}

// MARK: - UIHostingController
extension ModalRepresentable {
    class HostingController: UIHostingController<Content> {
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
}

// MARK: - UIViewControllerTransitioningDelegate
extension ModalRepresentable {
    class PresentationViewController: UIViewController, UIViewControllerTransitioningDelegate {
        func presentationController(
            forPresented presented: UIViewController,
            presenting: UIViewController?,
            source: UIViewController
        ) -> UIPresentationController? {
            PresentationController(
                presentedViewController: presented,
                presenting: presenting
            )
        }
    }
}

// MARK: - UIPresentationController
extension ModalRepresentable {
    class PresentationController: UIPresentationController {
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
}
