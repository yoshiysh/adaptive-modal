//
//  ModalOnFullScreenCover.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/10/13.
//

import AdaptiveModal
import SwiftUI

struct ModalOnFullScreenCover: View {
    @State var isPresented = false
    @State var isFullScreenVoverPresented = false

    var body: some View {
        Button {
            isFullScreenVoverPresented = true
        } label: {
            Text("Show FullScreenCover")
        }
        .navigationTitle("Modal on FullScreenCover Example")
        .fullScreenCover(isPresented: $isFullScreenVoverPresented) {
            VStack(spacing: 32) {
                Button {
                    isPresented = true
                } label: {
                    Text("Show Adaptive Modal")
                }

                Button {
                    isFullScreenVoverPresented = false
                } label: {
                    Text("Dismiss")
                }
            }
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
}

#Preview {
    ModalOnFullScreenCover()
}
