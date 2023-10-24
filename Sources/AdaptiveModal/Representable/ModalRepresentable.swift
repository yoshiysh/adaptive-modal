//
//  ModalRepresentable.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/02.
//

import SwiftUI

struct ModalRepresentable<Content: View> {
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
}

// MARK: - Coordinator
extension ModalRepresentable {
    typealias Coordinator = ModalCoordinator

    func makeCoordinator() -> Coordinator<Content> {
        ModalCoordinator(self)
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
            let hostingController = ModalHostingController(rootView: content())
            hostingController.transitioningDelegate = uiViewController
            DispatchQueue.main.async {
                uiViewController.present(hostingController, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                uiViewController.dismiss(animated: true) {
                    onDismiss()
                }
            }
        }
    }
}
