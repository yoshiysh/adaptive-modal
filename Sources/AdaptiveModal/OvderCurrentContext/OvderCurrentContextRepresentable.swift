//
//  OvderCurrentContextRepresentable.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/02.
//

import SwiftUI

struct OvderCurrentContextRepresentable<Content: View>: UIViewControllerRepresentable {
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

    func makeUIViewController(context: Context) -> some UIViewController {
        UIViewController()
    }

    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        let isHostingControllerPresented = uiViewController.presentedViewController is UIHostingController<Content>

        if isPresented {
            if isHostingControllerPresented { return }

            let hostingController = HostingController(rootView: content())
            DispatchQueue.main.async {
                uiViewController.present(hostingController, animated: false)
            }
        } else {
            if !isHostingControllerPresented { return }

            DispatchQueue.main.async {
                uiViewController.dismiss(animated: false) {
                    onDismiss()
                }
            }
        }
    }

    // MARK: - UIHostingController
    class HostingController: UIHostingController<Content> {
        override init(rootView: Content) {
            super.init(rootView: rootView)
            modalPresentationStyle = .overCurrentContext
            view.backgroundColor = .clear
        }
        
        @MainActor 
        required dynamic init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
