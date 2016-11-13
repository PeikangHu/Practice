//
//  Sequence.swift
//  Strategy
//
//  Created by Peikang Hu on 10/14/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

enum ALGORITHM
{
    case ADD
    case MULTIPLY
}

final class Sequence
{
    private var numbers:[Int]
    
    init(_ numbers:Int...)
    {
        self.numbers = numbers
    }
    
    func addNumber(value:Int)
    {
        self.numbers.append(value)
    }
    
    func compute(strategy:Strategy) ->Int
    {
        return strategy.execute(values: self.numbers)
    }
}
