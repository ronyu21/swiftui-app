//
//  Enumerations.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-06.
//

import Foundation


enum AppAction {
    case counter(CounterAction)
    case message(MessageAction)
}

enum CounterAction{
    case get
    case increment(Int)
    case decrement(Int)
}

enum MessageAction{
    case set(String)
    case append(String)
    case clear
}
