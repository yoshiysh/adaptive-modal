//
//  ModalPresentedKey.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2024/02/01.
//

import SwiftUI

struct ModalPresentedKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var isModalPresented: Binding<Bool> {
        get{ self[ModalPresentedKey.self] }
        set{ self[ModalPresentedKey.self] = newValue }
    }
}
