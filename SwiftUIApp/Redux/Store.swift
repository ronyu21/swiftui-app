//
//  Store.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-06.
//

import Foundation
import Combine

final class Store<State, Action>: ObservableObject {

    @Published private(set) var state: State
    
    private let reducer: Reducer<State, Action>
    private var cancellables: Set<AnyCancellable> = []

    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    func send(_ action: Action) {
        print("send Started")
        reducer
            .reduce(state, action)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: perform)
            .store(in: &cancellables)
        print("send completed")
    }

    private func perform(change: Reducer<State, Action>.Change) {
        print("perform started")
        change(&state)
        print("perform completed")
    }

}
