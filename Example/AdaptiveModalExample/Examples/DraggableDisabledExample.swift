//
//  DraggableDisabledExample.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/09/08.
//

import SwiftUI

struct DraggableDisabledExample: View {
    @State var isPresented = false

    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Show Adaptive Modal")
        }
        .navigationTitle("Draggable Disabled Example")
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
            .frame(height: 300)
            .modalDraggableDisabled()
        }
    }
}

#Preview {
    NavigationView {
        DraggableDisabledExample()
    }
}
