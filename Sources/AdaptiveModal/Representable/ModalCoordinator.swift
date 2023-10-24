//
//  ModalCoordinator.swift
//  AdaptiveModal
//
//  Created by yoshiysh on 2023/10/24.
//

import SwiftUI

class ModalCoordinator<Content: View>: NSObject {
    private let parent: ModalRepresentable<Content>

    init(_ parent: ModalRepresentable<Content>) {
        self.parent = parent
    }
}
