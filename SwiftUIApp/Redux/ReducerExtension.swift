//
//  ReducerExtension.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-06.
//

import Foundation

protocol CounterService {
    var counter: Int { get }
    
    func increment(_ value: Int)
    
    func decrement(_ value: Int)
    
    func getCounter() -> Int
}

class MockCounterService: CounterService{
    var counter = 0

    func increment(_ value: Int) {
        print("Increment")
        
//        sleep(1)
        self.counter += value
        print("Incremented")
    }
    
    func decrement(_ value: Int) {
        self.counter -= value
    }
    
    
    func getCounter() -> Int {
        print("GetCounter")
//        sleep(2)
        print("GetCounter return")
        return counter
    }
}

extension Reducer where State == AppState, Action == AppAction {
    static func appReducer() -> Reducer {
        let counterService: CounterService = MockCounterService()

        return Reducer { state, action in
            print("appReducer return")
            switch action {
            case .counter(let action):
                handleCounterAction(action, counterService: counterService)
            case .message(let action):
//                state.message = handleMessageAction(action)
                return Reducer.sync { (state) in
                    print("Sync")
                    state.message = handleMessageAction(state, action)
                }
            }
            
            return Reducer.sync { state in
                print("Sync")
                print(action)
                state.counter = counterService.getCounter()
            }
        }
    }
    
    private static func handleCounterAction(_ action: CounterAction, counterService: CounterService){
        switch action{
            
            case .get:
                break
            case .increment(let value):
                counterService.increment(value)
            case .decrement(let value):
                counterService.decrement(value)
        }
    }
    
    private static func handleMessageAction(_ prevState: AppState, _ action: MessageAction) -> String {
        print("handleMessageAction")
        switch action{
            case .clear:
                return ""
            case .set(let value):
                return value
            
            case .append(let value):
                return prevState.message.appending(value)
        }
    }

}
