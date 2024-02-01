//
//  ModalBackgroundColor.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2024/02/01.
//

import SwiftUI

struct ModalBackgroundColor: PreferenceKey {
    typealias Value = Color?

    static let defaultValue: Value = Color(UIColor.secondarySystemBackground)
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue() ?? defaultValue
    }
}
