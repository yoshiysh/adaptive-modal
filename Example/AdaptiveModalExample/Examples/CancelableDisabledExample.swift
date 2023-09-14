//
//  CancelableDisabledExample.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/09/08.
//

import SwiftUI

struct CancelableDisabledExample: View {
    @State var isPresented = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Show Adaptive Modal")
        }
        .navigationTitle("Cancelable Disabled Example")
        .adaptiveModal(
            isPresented: $isPresented,
            cancelable: false
        ) {
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
        CancelableDisabledExample()
    }
}
