//
//  AppState.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-06.
//

import Foundation

//final class AppState: ReduxState, Equatable {
//
//    let count: Int
//
//}

//struct AppState: ReduxState, Equatable{
//    
//    let count: Int
//}

struct AppState {
//    var chats: [Chat] = []
//    var messages: [Message] = []
//    var currentUser: String? = nil
//
//    func messages(in chat: Chat) -> [Message] {
//        messages.filter { $0.chatId == chat.id }
//    }
    
    var counter = 0
    
    var message = ""
    
}
