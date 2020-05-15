//
//  MockingBirdTest.swift
//  SwiftUIAppTests
//
//  Created by Ron Yu on 2020-05-08.
//

import XCTest
import Mockingbird
@testable import SwiftUIApp

class MockingBirdTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testShakingTreeCausesBirdToFly() {
      // Given a tree with a bird that can fly
      let bird = mock(Bird.self)
      let tree = Tree(with: bird)
      given(bird.getCanFly()) ~> true

      // When the tree is shaken
      tree.shake()

      // Then the bird flies away
      verify(bird.fly()).wasCalled()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
