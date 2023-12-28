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
    ///   - draggable: if true, then content draggable y-axis
    ///     if false, then undraggable
    ///   - cancelable: if true, then  tapping this background or swiping down dismiss,
    ///     if false, then  has no effect.
    ///   - onDismiss: The closure to execute when dismissing the modal view.
    ///   - content: A closure that returns the content of the modal view.
    func adaptiveModal(
        isPresented: Binding<Bool>,
        draggable: Bool = true,
        cancelable: Bool = true,
        backgroundColor: Color? = Color(UIColor.secondarySystemBackground),
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(AdaptiveModalViewModifier(
            isPresented: isPresented,
            draggable: draggable,
            cancelable: cancelable,
            backgroundColor: backgroundColor,
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
    ///   - draggable: if true, then content draggable y-axis
    ///     if false, then undraggable
    ///   - cancelable: if true, then  tapping this background or swiping down dismiss,
    ///     if false,  then  has no effect.
    ///   - onDismiss: The closure to execute when dismissing the modal view.
    ///   - content: A closure that returns the content of the modal view.
    func adaptiveModal<Item: Identifiable>(
        item: Binding<Item?>,
        draggable: Bool = true,
        cancelable: Bool = true,
        backgroundColor: Color? = Color(UIColor.secondarySystemBackground),
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Item) -> some View
    ) -> some View {
        adaptiveModal(
            isPresented: .init(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            draggable: draggable,
            cancelable: cancelable,
            backgroundColor: backgroundColor,
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
