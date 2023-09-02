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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }
        .padding()
        .adaptivePanel(isPresented: $isPresented) {
            EmptyView()
        }
    }
}

#Preview {
    ContentView()
}
