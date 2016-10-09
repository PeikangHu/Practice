//
//  CarParts.swift
//  Composite
//
//  Created by Peikang Hu on 10/5/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol CarPart
{
    var name:String { get }
    var price:Float { get }
    
    func addPart(part:CarPart) -> Void
    func removePart(part:CarPart) -> Void
}

// a single self-contained part: a spark plug or a tire
class Part : CarPart
{
    let name:String
    let price:Float
    
    init(name:String, price:Float)
    {
        self.name = name
        self.price = price
    }
    
    func addPart(part: CarPart) {
        // do nothing
    }
    
    func removePart(part: CarPart) {
        // do nothing
    }
}

// are made up of other parts and that are typically purchased as a single unit
// a wheel - would comprise a tire, a wheel alloy, and some fixing nuts
class CompositePart : CarPart
{
    let name:String
    fileprivate var parts:[CarPart]
    
    init(name:String, parts:CarPart...)
    {
        self.name = name
        self.parts = parts
    }
    
    var price:Float
    {
        return parts.reduce(0, { (subtotal, part) in
                                return subtotal + part.price
                                }
                            )
    }
    
    func addPart(part:CarPart)
    {
        parts.append(part)
    }
    
    func removePart(part:CarPart)
    {
        for index in 0..<parts.count
        {
            if parts[index].name == part.name
            {
                parts.remove(at: index)
                break
            }
        }
    }
    
    
}
