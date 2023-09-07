//
//  BlueButton.swift
//  AdaptiveModalExample
//
//  Created by yoshi on 2023/09/07.
//

import SwiftUI

struct BlueButton: View {
    private let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Dismiss")
                .font(.title2)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(
                    Rectangle()
                        .fill(.blue)
                        .ignoresSafeArea()
                )
        }
    }
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
}
