//
//  AdaptivePanel.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

public extension View {
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether
    ///     to present the sheet.
    ///   - draggable: if true, then content draggable y-axis
    ///     if false, then undraggable
    ///   - cancelable: if true, then  tapping this background or swiping down dismiss,
    ///     if false,  then  has no effect.
    ///   - onDismiss: The closure to execute when dismissing the modal view.
    ///   - content: A closure that returns the content of the modal view.
    @MainActor
    func adaptivePanel(
        isPresented: Binding<Bool>,
        draggable: Bool = true,
        cancelable: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        modifier(AdaptivePanelViewModifier(
            isPresented: isPresented,
            draggable: draggable,
            cancelable: cancelable,
            onDismiss: onDismiss,
            content: content
        ))
    }
}
