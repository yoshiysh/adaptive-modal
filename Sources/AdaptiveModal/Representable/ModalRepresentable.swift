//
//  ModalRepresentable.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/02.
//

import SwiftUI

struct ModalRepresentable {
    @Binding var isPresented: Bool
    let onDismiss: () -> Void
    let content: () -> ModalContent
    let viewController = ModalViewController()

    init(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void,
        content: @escaping () -> ModalContent
    ) {
        _isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content
    }
}

// MARK: - Coordinator
extension ModalRepresentable {
    typealias Coordinator = ModalCoordinator

    func makeCoordinator() -> Coordinator {
        ModalCoordinator(self)
    }
}

// MARK: - UIViewControllerRepresentable
extension ModalRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ModalViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        viewController
    }

    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        if isPresented {
            present(uiViewController, context: context)
        } else {
            dismiss(uiViewController)
        }
    }

    func isHostingControllerPresented(_ uiViewController: UIViewControllerType) -> Bool {
        uiViewController.presentedViewController is UIHostingController<ModalContent>
    }
    
    func present(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        if isHostingControllerPresented(uiViewController) { return }

        var modalContent = content()
        modalContent.delegate = context.coordinator

        let hostingController = ModalHostingController(rootView: modalContent)
        hostingController.transitioningDelegate = uiViewController
        DispatchQueue.main.async {
            uiViewController.present(hostingController, animated: true)
        }
    }
    
    func dismiss(_ uiViewController: UIViewControllerType) {
        if !isHostingControllerPresented(uiViewController) { return }

        DispatchQueue.main.async {
            uiViewController.dismiss(animated: true) {
                onDismiss()
            }
        }
    }
}
