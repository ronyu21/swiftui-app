//
//  AdvanceUserDefaultsExample.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-06-09.
//

import SwiftUI



extension Key {
    static let isFirstLaunch: Key = "isFirstLaunch"
}

struct Storage {
    
    @UserDefault(key: .isFirstLaunch)
    var isFirstLaunch: Bool?
}


// Reference: https://www.vadimbulavin.com/advanced-guide-to-userdefaults-in-swift/
struct AdvanceUserDefaultsExample: View {
    
    // get the stored value from UserDefault when the app is openning
    @State var isFirstLaunch: Bool = Storage().isFirstLaunch ?? true
    
    var body: some View {
        VStack{
            Text("UserDefaults Example")
            Text("First Launch: \(String(isFirstLaunch))")
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.removeObject(forKey: Key.isFirstLaunch.rawValue)
            }, label: {
                Text("Delete the isFirstLaunch storage")
            })
        }
            .onDisappear(){
                
                var storage = Storage()
                // set the UserDefaults isFirstLaunch to false after this visit at this page.
                storage.isFirstLaunch = false
                
                // needs to completely close the app and re-open to see the value change of isFirstLaunch
//
//                self.storage.isFirstLaunch = nil
//                // how to use observe
//                var observation = self.storage.$isFirstLaunch.observe { (old, new) in
//                    print("Changed from: \(old) to \(new)")
//                }
//
//                self.storage.isFirstLaunch = true
//                self.storage.isFirstLaunch?.toggle()
                
        }
    }
}

struct AdvanceUserDefaultsExample_Previews: PreviewProvider {
    static var previews: some View {
        AdvanceUserDefaultsExample()
    }
}
