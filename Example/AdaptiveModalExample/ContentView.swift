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
                        DraggableDisabledExample()
                    }
                    NavigationLink("Cancelable Disabled") {
                        CancelableDisabledExample()
                    }
                } header: {
                    Text("Basic")
                }

                Section {
                    NavigationLink("DisclosureGroup Example") {
                        DisclosureGroupExample()
                    }
                    NavigationLink("Item Binding Example") {
                        ItemBindingExample()
                    }
                    NavigationLink("Sheet After Close Modal Example") {
                        SheetAfterCloseModal()
                    }
                } header: {
                    Text("Extra")
                }
            }
            .navigationTitle("Examples")
        }
    }
}

#Preview {
    ContentView()
}
