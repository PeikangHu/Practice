//
//  Strategy.swift
//  Strategy
//
//  Created by Peikang Hu on 10/14/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

// As closure
class ClosureStrategy:Strategy
{
    private let closure:([Int]) -> Int
    
    init(_ closure:@escaping ([Int])->Int)
    {
        self.closure = closure
    }
    
    func execute(values: [Int]) -> Int {
        return self.closure(values)
    }
}

// As Class
protocol Strategy
{
    func execute(values:[Int]) -> Int
}

class SumStrategy:Strategy
{
    func execute(values: [Int]) -> Int {
        return values.reduce(0, { $0 + $1})
    }
}

class MultiplyStrategy:Strategy
{
    func execute(values: [Int]) -> Int {
        return values.reduce(1, { $0 * $1})
    }
}
