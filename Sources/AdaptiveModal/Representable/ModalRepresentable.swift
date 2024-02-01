//
//  ModalRepresentable.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/02.
//

import SwiftUI

struct ModalRepresentable<Content: View> {
    @Environment(\.isModalPresented) @Binding var isPresented
    
    let onDismiss: () -> Void
    let content: () -> Content

    init(
        onDismiss: @escaping () -> Void,
        content: @escaping () -> Content
    ) {
        self.onDismiss = onDismiss
        self.content = content
    }
}

// MARK: - UIViewControllerRepresentable
extension ModalRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ModalViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        ModalViewController()
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
        
        guard var rootView = content() as? ModalContent else {
            fatalError("Content is invalid.")
        }
        rootView.delegate = uiViewController

        let hostingController = ModalHostingController(rootView: rootView)
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
