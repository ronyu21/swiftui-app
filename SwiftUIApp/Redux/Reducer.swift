//
//  Reducer.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-06.
//

import Foundation
import Combine


struct Reducer<State, Action> {
    /// Change is a function takes in State, modify the State in the function and returns nothing
    typealias Change = (inout State) -> Void
    
    let reduce: (State, Action) -> AnyPublisher<Change, Never>
}

extension Reducer {
    static func sync(_ fun: @escaping (inout State) -> Void) -> AnyPublisher<Change, Never> {
        Just(fun).eraseToAnyPublisher()
    }
}


extension Reducer {
    
}
