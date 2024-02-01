//
//  AdaptiveModal.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

public extension View {
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether
    ///     to present the modal view.
    ///   - onDismiss: The closure to execute when dismissing the modal view.
    ///   - content: A closure that returns the content of the modal view.
    func adaptiveModal(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(AdaptiveModalViewModifier(
            isPresented: isPresented,
            onDismiss: onDismiss,
            content: content
        ))
    }

    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the modal view.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a modal view that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the modal view and replaces it with a new one
    ///     using the same process.
    ///   - onDismiss: The closure to execute when dismissing the modal view.
    ///   - content: A closure that returns the content of the modal view.
    func adaptiveModal<Item: Identifiable>(
        item: Binding<Item?>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> some View
    ) -> some View {
        adaptiveModal(
            isPresented: .init(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            onDismiss: onDismiss,
            content: {
                Group {
                    if let wrappedValue = item.wrappedValue {
                        content(wrappedValue)
                    }
                }
            }
        )
    }
}

public extension View {
    /// - Parameter isDisabled: A Boolean value that indicates whether to
    ///   prevent nonprogrammatic dismissal of the containing view hierarchy
    ///   when presented in a adaptive modal.
    func modalInteractiveDismissDisabled(_ isDisabled: Bool = true) -> some View {
        preference(key: ModalInteractiveDismissDisabled.self, value: isDisabled)
    }

    /// - Parameter isDisabled: A Boolean value that indicates whether to
    ///   prevent nonprogrammatic dismissal of the containing view hierarchy
    ///   when presented in a adaptive modal.
    func modalDraggableDisabled(_ isDisabled: Bool = true) -> some View {
        preference(key: ModalDraggableDisabled.self, value: isDisabled)
    }

    /// - Parameter color: The background color to use when displaying this
    ///   view. Pass `nil` to remove any custom background color and to allow
    ///   the system or the container to provide its own foreground color.
    func modalBackgroundColor(_ color: Color?) -> some View {
        preference(key: ModalBackgroundColor.self, value: color)
    }
}
