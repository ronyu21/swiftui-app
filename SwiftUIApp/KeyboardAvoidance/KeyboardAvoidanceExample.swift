//
//  KeyboardAvoidanceExample.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-06-07.
//

import SwiftUI
import Combine

// Reference: https://www.vadimbulavin.com/how-to-move-swiftui-view-when-keyboard-covers-text-field/
struct KeyboardAvoidanceExample: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Enter something", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            Spacer()
        }
        .padding()
        .keyboardAdaptive()  // apply custom modifier
    }
}

struct KeyboardAvoidanceExample_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardAvoidanceExample()
    }
}


struct KeyboardAvoidanceExampleDirectUse: View {
    @State private var text = ""

    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Enter something", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
        .padding(.bottom, keyboardHeight)
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}
