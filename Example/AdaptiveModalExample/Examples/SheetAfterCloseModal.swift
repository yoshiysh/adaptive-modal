//
//  SheetAfterCloseModal.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/10/02.
//

import AdaptiveModal
import SwiftUI

struct SheetAfterCloseModal: View {
    @State var isPresented = false
    @State var isSheetPresented = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Show Adaptive Modal")
        }
        .navigationTitle("Sheet After Close Modal Example")
        .sheet(isPresented: $isSheetPresented) {
            VStack {
                LongText()
                    .frame(maxHeight: 200)
                    .padding()

                BlueButton {
                    isSheetPresented = false
                }
            }
        }
        .adaptiveModal(
            isPresented: $isPresented,
            onDismiss: { isSheetPresented = true }
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
