//
//  ScrollViewExample.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/09/07.
//

import SwiftUI

struct ScrollViewExample: View {
    @State var isPresented = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Show Adaptive Modal")
        }
        .navigationTitle("Scroll View Example")
        .adaptiveModal(isPresented: $isPresented) {
            VStack {
                Color.gray
                    .frame(width: 50, height: 4)
                    .clipShape(.capsule)
                    .padding(.top)

                ScrollView {
                    VStack {
                        LongText()
                            .padding()
                        
                        BlueButton {
                            isPresented = false
                        }
                    }
                }
            }
            .frame(height: 400)
        }
    }
}

#Preview {
    NavigationView {
        ScrollViewExample()
    }
}
