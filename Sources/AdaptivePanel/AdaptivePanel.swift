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
        @ViewBuilder content: @escaping () -> some View,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        AdaptivePanel(
            targetView: self,
            isPresented: isPresented,
            content: content,
            onDismiss: onDismiss
        )
    }
}
