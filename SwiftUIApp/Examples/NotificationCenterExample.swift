//
//  NotificationCenterExample.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-05.
//

import SwiftUI
import Combine

class NotificationHandler: ObservableObject {
    
    @Published var message : String? = nil
    
    var messageReceivedCounter = 0
    
    let onReceive = Notification.Name("didReceiveData")
    
    let onClear = Notification.Name("didClearData")
    
    var addedObservers = false
    
    func setupObservers(){
        
        if !addedObservers{
            // Prevent adding duplicate observer
            NotificationCenter.default.addObserver(self, selector: #selector(didReceiveData(_:)), name: self.onReceive, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(didClearData(_:)), name: self.onClear, object: nil)
            addedObservers = true
        }
            
    }
    
    @objc func didReceiveData(_ notification: Notification){
        if let data = notification.userInfo as? [String: String] {
            message = data["message"]
        }
        self.messageReceivedCounter += 1
    }
    
    @objc func didClearData(_ notification: Notification){
        message = nil
        self.messageReceivedCounter += 1
    }
}

struct NotificationCenterExample: View {
    
    let nc = NotificationCenter.default
    
    /// Using Notification center only
    @ObservedObject var notifier = NotificationHandler()
    
    @State var input: String = ""
    
    /// Using Combine and Notification Center
    @State var cancellable: AnyCancellable? = nil
    
    @State var msg : String? = nil
    
    var body: some View {
        VStack{
            
            Text("Counter[\(notifier.messageReceivedCounter)]: \(notifier.message ?? "")")
                .font(.title)
            
            Form{
                TextField("Message", text: $input)
                
                Button(action: {
                    self.postMessageSet(self.input)
                }) {
                    Text("Publish")
                }
                Button(action: {
                    self.postMessageClear()
                    self.input = ""
                }){
                    Text("Clear")
                }
            }
        }
        .onAppear(){
            self.registerNotifications()
        }
        .onDisappear(){
            // Removes current subscriber to the notification center event
            self.cancellable?.cancel()
        }
            
        .navigationBarTitle("Notification Center Example")
    }
    
    func registerNotifications(){
        notifier.setupObservers()
        
        // Subscribes to the notification publisher
        self.cancellable = NotificationCenter.Publisher(center: .default, name: notifier.onReceive)
            .sink { notification in
                print(notification)
                if let data = notification.userInfo as? [String: String] {
                    self.msg = data["message"]
                    print(self.msg)
                }
        }
        
    }
    
    func postMessageSet(_ message: String){
        nc.post(name: notifier.onReceive, object: nil, userInfo: ["message": message])
    }
    
    func postMessageClear(){
        nc.post(name: notifier.onClear, object: nil)
    }
    
}

struct NotificationCenterExample_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCenterExample()
    }
}
