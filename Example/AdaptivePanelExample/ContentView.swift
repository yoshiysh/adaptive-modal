//
//  ContentView.swift
//  AdaptivePanelExample
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI
import AdaptivePanel

struct ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        contentView(
            "Hello, World!",
            buttonLabel: "Press Me"
        )
        .padding()
        .adaptivePanel(isPresented: $isPresented) {
            VStack(spacing: 32) {
                contentView(
                    "Adaptive Panel World!",
                    buttonLabel: "dismiss"
                )
                .padding()

                Button {} label: {
                    Text("Button")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Rectangle()
                                .fill(.green)
                                .ignoresSafeArea()
                        )
                }
            }
        } onDismiss: {
            print("adaptive panel on dismissed")
        }
    }
}

private extension ContentView {
    @MainActor
    func contentView(
        _ title: String,
        buttonLabel: String
    ) -> some View {
        VStack(spacing: 32) {
            Text(title)
                .multilineTextAlignment(.center)
                .font(.title)
            Button {
                isPresented.toggle()
            } label: {
                Text(buttonLabel)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue)
                    )
            }
        }
    }
}

#Preview {
    ContentView()
}
