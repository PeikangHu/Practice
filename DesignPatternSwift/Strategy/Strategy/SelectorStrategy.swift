//
//  SelectorStrategy.swift
//  Strategy
//
//  Created by Peikang Hu on 10/15/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

// Selector-Based Strategies
@objc class City : NSObject
{
    let name:String
    
    init(_ name:String)
    {
        self.name = name
    }
    
    func compareTo(other:City) -> ComparisonResult
    {
        if self.name == other.name
        {
            return ComparisonResult.orderedSame
        }
        else if self.name < other.name
        {
            return .orderedDescending
        }
        else
        {
            return .orderedAscending
        }
    }
}

let nsArray = NSArray(array: [City("London"), City("New York"), City("Paris"), City("Rome")])
let sorted = nsArray.sortedArray(using: "compareTo:")

for city in sorted
{
    print(city.name)
}
