//
//  CounterRequest.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 31/5/23.
//

import Foundation

struct CounterRequest {
    var currentCount: Int
    let maxAmount: Int
    
    init(maxAmount: Int) {
        self.currentCount = 0
        self.maxAmount = maxAmount
    }
}
