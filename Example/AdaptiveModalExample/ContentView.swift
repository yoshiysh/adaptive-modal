//
//  ContentView.swift
//  AdaptiveModalExample
//
//  Created by yoshiysh on 2023/09/02.
//

import SwiftUI
import AdaptiveModal

struct ContentView: View {
    @State var isPresented = false
    @State var isOn = false
    @State var text: String = ""
    
    static let dummyText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"
    
    var body: some View {
        contentView(
            "Hello, World!",
            buttonLabel: "Press Me"
        )
        .padding()
        .adaptiveModal(
            isPresented: $isPresented,
            draggable: true,
            cancelable: true,
            onDismiss: { print("adaptive modal on dismissed") }
        ) {
            panelContent()
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
    
    @MainActor
    func panelContent() -> some View {
        VStack {
            VStack(spacing: 32) {
                contentView(
                    "Hello Adaptive Modal",
                    buttonLabel: "Dismiss"
                )
                
                Toggle(isOn: $isOn) {
                    Text("Toggle")
                }
                
                TextField("TextField", text: $text)
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
            
            if isOn {
                Text(ContentView.dummyText)
            }
            
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
        .padding(.top, 32)
    }
}

#Preview {
    ContentView()
}
