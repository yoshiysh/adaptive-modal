//
//  Binding.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2024/02/01.
//

import SwiftUI

extension Binding {
    func isPresent<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        .init(
            get: { self.wrappedValue != nil },
            set: { isPresent, transaction in
                guard !isPresent else {
                    return
                }
                self.transaction(transaction).wrappedValue = nil
            }
        )
    }
}
