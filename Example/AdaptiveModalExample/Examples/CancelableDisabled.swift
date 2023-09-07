//
//  CancelableDisabled.swift
//  AdaptiveModalExample
//
//  Created by yoshi on 2023/09/08.
//

import SwiftUI

struct CancelableDisabled: View {
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
        CancelableDisabled()
    }
}
