//
//  DisclosureGroupExample.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/09/08.
//

import SwiftUI

struct DisclosureGroupExample: View {
    @State var isPresented = false
    @State var isExpanded = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Show Adaptive Modal")
        }
        .navigationTitle("DisclosureGroup Example")
        .adaptiveModal(isPresented: $isPresented) {
            VStack {
                DisclosureGroup(
                    isExpanded: $isExpanded,
                    content: {
                        LongText()
                            .frame(maxHeight: 200)
                    }, label: {
                        Text("DisclosureGroup Text")
                    }
                )
                .padding()

                BlueButton {
                    isPresented = false
                }
            }
        }
    }
}
