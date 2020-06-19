//
//  HelperFunctions.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-06-18.
//

import Foundation


// Undefined as a type

func undefined<T>(_ message: String = "") -> T {
    fatalError("Undefined: \(message)")
}

// examples

let name: String = undefined("Example string")
let score: Int = undefined("Example int")

func userID(for username: String) -> Int? {
    undefined(username)
}

let timer = Timer(timeInterval: undefined(), target: undefined(), selector: undefined(), userInfo: undefined(), repeats: undefined())

