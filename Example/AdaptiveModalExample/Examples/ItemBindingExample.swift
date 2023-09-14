//
//  ItemBindingExample.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/09/14.
//

import AdaptiveModal
import SwiftUI

struct ItemBindingExample: View {
    @State private var sheetDetail: InventoryItem?

    var body: some View {
        VStack(spacing: 32) {
            Button {
                sheetDetail = InventoryItem(
                    id: "0123456789",
                    partNumber: "Z-1234A",
                    quantity: 100,
                    name: "Widget"
                )
            } label: {
                Text("Show Adaptive Modal: 1")
            }

            Button {
                sheetDetail = InventoryItem(
                    id: "123123123",
                    partNumber: "A-4567Z",
                    quantity: 50,
                    name: "Parts"
                )
            } label: {
                Text("Show Adaptive Modal: 2")
            }
        }
        .navigationTitle("Item Binding Example")
        .adaptiveModal(item: $sheetDetail) { detail in
            VStack {
                Group {
                    Text("Part Number: \(detail.partNumber)")
                    Text("Name: \(detail.name)")
                    Text("Quantity On-Hand: \(detail.quantity)")
                }
                .padding()
                
                BlueButton {
                    sheetDetail = nil
                }
            }
        }
    }
    
    struct InventoryItem: Identifiable {
        var id: String
        let partNumber: String
        let quantity: Int
        let name: String
    }
}

#Preview {
    NavigationView {
        ItemBindingExample()
    }
}
