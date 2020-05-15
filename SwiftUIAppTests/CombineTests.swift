//
//  CombineTests.swift
//  SwiftUIAppTests
//
//  Created by Ron Yu on 2020-05-14.
//

import Alamofire
import Combine
import SwiftyJSON
import XCTest

class CombineTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testPassthroughSubjectSuccess() throws {
        
        let expectation = XCTestExpectation(description: "Testing PassthroughSubject")
        
        let subject = PassthroughSubject<String, Never>()
        let publisher = Just("Hello World")
        
        let c1 = publisher.subscribe(subject)
        
        let cancellable = subject.sink(receiveCompletion: { (completion) in
            if case let .failure(error) = completion {
                print(error)
            }
            expectation.fulfill()
        }) { (value) in
            print(value)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(cancellable)
        
    }
    
    struct TestError: Error {
        var message: String?
    }
    
    func testPassthroughSubjectFailure() throws {
        
        let expectation = XCTestExpectation(description: "Testing PassthroughSubject")
        
        let subject = PassthroughSubject<String, TestError>()
        let publisher = Future<String, TestError> { promise in
            
            promise(.failure(TestError(message: "Error World")))
        }
        
        let c1 = publisher.subscribe(subject)
        
        let cancellable = subject.sink(receiveCompletion: { (completion) in
            if case let .failure(error) = completion {
                print(error)
            }
            expectation.fulfill()
        }) { (value) in
            XCTFail()
            
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(cancellable)
        
    }
    
    func testPassthroughSubjectSuccessWithAsync() throws {
        let expectation = XCTestExpectation(description: "Testing PassthroughSubject with async")
        
        let subject = PassthroughSubject<String, TestError>()
        let publisher = Future<String, TestError> { promise in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                promise(.success("Hello world from async"))
            }
        }
        
        let c1 = publisher.subscribe(subject)
        
        let cancellable = subject.sink(receiveCompletion: { (completion) in
            if case let .failure(error) = completion {
                print(error)
            }
            expectation.fulfill()
        }) { (value) in
            print(value)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(cancellable)
        
    }
    
    
    func testPassthroughSubjectSuccessWithApi() throws {
        let expectation = XCTestExpectation(description: "Testing PassthroughSubject with async")
        
        let subject = PassthroughSubject<String, TestError>()
        let publisher = Future<String, TestError> { promise in
            
            AF.request("https://app.fakejson.com/q",
                       method: .post,
                       parameters: JSON([
                        "token": "y--U0dkIgEQ-GstOLLdfiA",
                        "data": ["email": "internetEmail"]
                        ]),
                       encoder: JSONParameterEncoder.default,
                       headers: [
                           "Accept": "application/json",
                           "Content-Type": "application/json"
                       ]
                       )
                .responseJSON { (response) in
                    print(response)
                    switch response.result {
                        case .success(let data):
                            let json = JSON(data)
                            promise(.success(json["email"].stringValue))
                        case .failure(_):
                            promise(.failure(TestError(message: "api failed")))
                    }
            }
        }.eraseToAnyPublisher()
        
        let c1 = publisher.subscribe(subject)

        let subject2 = PassthroughSubject<String, TestError>()
        
        let c2 = subject.sink(receiveCompletion: { (completion) in
            if case let .failure(error) = completion {
                print(error)
                subject2.send(completion: .failure(TestError(message: "Subject2 " + error.message!)))
            }
        }) { (value) in
            subject2.send("subject2 " + value)
        }
        
        let c3 = subject2.sink(receiveCompletion: { (completion) in
            if case let .failure(error) = completion {
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }) { (value) in
            print(value)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(c2)
        
    }
    
    
    func testDeferredFutureSuccessWithApi() throws {
        let expectation = XCTestExpectation(description: "Testing Deferred with async")
        
        let subject = PassthroughSubject<String, TestError>()
        let publisher = Future<String, TestError> { promise in
            
            AF.request("https://app.fakejson.com/q",
                       method: .post,
                       parameters: JSON([
                        "token": "y--U0dkIgEQ-GstOLLdfiA",
                        "data": ["email": "internetEmail"]
                        ]),
                       encoder: JSONParameterEncoder.default,
                       headers: [
                           "Accept": "application/json",
                           "Content-Type": "application/json"
                       ]
                       )
                .responseJSON { (response) in
                    print(response)
                    switch response.result {
                        case .success(let data):
                            let json = JSON(data)
                            promise(.success(json["email"].stringValue))
                        case .failure(_):
                            promise(.failure(TestError(message: "api failed")))
                    }
            }
        }.eraseToAnyPublisher()
        
        let c1 = publisher.subscribe(subject)
        
//        let finalPub = Deferred {
//            Future<String, TestError>{ promise in
//                subject.sink(receiveCompletion: { (completion) in
//                    if case let .failure(error) = completion {
//                        print(error)
//                        promise(.failure(TestError(message: "deferred " + error.message!)))
//                    }
//                }) { (value) in
//                    promise(.success("deferred " + value))
//                }
//            }
//        }.eraseToAnyPublisher()
        
        var cancellables: Set<AnyCancellable> = []
        
        Deferred {
            Future<String, TestError>{ promise in
                subject.sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        print(error)
                        promise(.failure(TestError(message: "deferred " + error.message!)))
                    }
                }) { (value) in
                    promise(.success("deferred " + value))
                }.store(in: &cancellables)
            }
        }
        .eraseToAnyPublisher()
        .print()
        .sink(receiveCompletion: { (completion) in
            if case let .failure(error) = completion {
                print(error)
                XCTFail()
            }
            expectation.fulfill()
        }) { (value) in
            print(value)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        
//        let c3 = finalPub.sink(receiveCompletion: { (completion) in
//            if case let .failure(error) = completion {
//                print(error)
//                XCTFail()
//            }
//            expectation.fulfill()
//        }) { (value) in
//            print(value)
//            expectation.fulfill()
//        }

        wait(for: [expectation], timeout: 10)
//        XCTAssertNotNil(can)
        
    }
}
