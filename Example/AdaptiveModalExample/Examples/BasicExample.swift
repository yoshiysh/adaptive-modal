//
//  BasicExample.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/09/07.
//

import AdaptiveModal
import SwiftUI

struct BasicExample: View {
    @State var isPresented = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Show Adaptive Modal")
        }
        .navigationTitle("Basic Example")
        .adaptiveModal(isPresented: $isPresented) {
            VStack {
                LongText()
                    .frame(maxHeight: 200)
                    .padding()

                BlueButton {
                    isPresented = false
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        BasicExample()
    }
}
