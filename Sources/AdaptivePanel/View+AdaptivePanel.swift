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
    ///   - barrierDismissible: if true, then  tapping this background dismiss,
    ///     if false,  then tapping the background has no effect.
    ///   - onDismiss: The closure to execute when dismissing the modal view.
    ///   - content: A closure that returns the content of the modal view.
    @MainActor
    func adaptivePanel(
        isPresented: Binding<Bool>,
        barrierDismissible: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        AdaptivePanel(
            targetView: self,
            isPresented: isPresented,
            barrierDismissible: barrierDismissible,
            onDismiss: onDismiss,
            content: content
        )
    }
}
