//
//  ModalDraggableDisabled.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2024/02/01.
//

import SwiftUI

struct ModalDraggableDisabled: PreferenceKey {
    typealias Value = Bool

    static let defaultValue: Value = false
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
