//
//  Tree.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-08.
//

import Foundation

class Tree {
  let bird: Bird
  
  init(with bird: Bird) {
    self.bird = bird
  }
  
  func shake() {
    guard bird.canFly else { return }
    bird.fly()
  }
}
 
