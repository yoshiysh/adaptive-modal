//
//  ContentView.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI
import AdaptiveModal

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink("Basic Example") {
                        BasicExample()
                    }
                    NavigationLink("Scroll View Example") {
                        ScrollViewExample()
                    }
                    NavigationLink("Draggable Disabled") {
                        DraggableDisabled()
                    }
                    NavigationLink("Cancelable Disabled") {
                        CancelableDisabled()
                    }
                } header: {
                    Text("Basic")
                }
            }
            .navigationTitle("Examples")
        }
    }
}

#Preview {
    ContentView()
}
