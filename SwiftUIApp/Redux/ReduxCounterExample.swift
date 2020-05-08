//
//  ReduxCounterExample.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-06.
//

import SwiftUI

struct ReduxCounterExample: View {
    
    @EnvironmentObject private var store : Store<AppState, AppAction>
    
    @State var value: String = ""
    
    var body: some View {
        VStack{
            
            Text("Current Counter \(store.state.counter)")
                .font(.title)
            
            HStack{
                Spacer()
                Button(action: {
                    let intVal = Int(self.value) ?? 1
                    self.store.send(.counter(.increment(intVal)))
                    self.store.send(.message(.set(self.value)))
                }) {
                    Text("Increment")
                }
                
                TextField("Value", text: $value)
                
                Button(action: {
                    let intVal = Int(self.value) ?? 1
                    self.store.send(.counter(.decrement(intVal)))
                    self.store.send(.message(.clear))
                }){
                    Text("Decrement")
                }
                Spacer()
            }
        
            Text(store.state.message)
            Button(action: {
                self.store.send(.message(.append(self.value)))
            }){
                Text("Append")
            }
        }
    }
}

struct ReduxCounterExample_Previews: PreviewProvider {
    static var previews: some View {
        ReduxCounterExample()
    }
}
