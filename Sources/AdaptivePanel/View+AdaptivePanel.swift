//
//  AdaptivePanel.swift
//  AdaptivePanel
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI

public extension View {
    @MainActor
    func adaptivePanel(
        isPresented: Binding<Bool>,
        barrierDismissible: Bool = false,
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
