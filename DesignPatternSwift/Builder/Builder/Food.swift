//
//  Food.swift
//  Builder
//
//  Created by Peikang Hu on 9/29/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class Burger
{
    let customerName:String
    let veggieProduct:Bool
    let patties:Int
    let pickles:Bool
    let mayo:Bool
    let ketchup:Bool
    let lettuce:Bool
    let cook:Cooked
    
    enum Cooked:String {
        case RARE = "Rare"
        case NORMAL = "Normal"
        case WELLDONE = "Well Done"
    }
    
    // Avoid telescoping initializers (Too many initializers) in Swift by using default parameter values, like this:
    // init(flavor: Flavor, size:Size = Size.MEDIUM, count:Int = 1)
    init(name: String,  veggie:Bool, patties:Int, pickles:Bool,
                        mayo:Bool, ketchup:Bool, lettuce:Bool, cook:Cooked)
    {
        self.customerName = name
        self.veggieProduct = veggie
        self.patties = patties
        self.pickles = pickles
        self.mayo = mayo
        self.ketchup = ketchup
        self.lettuce = lettuce
        self.cook = cook
    }
    
    func printDescription()
    {
        print("Name \(self.customerName)")
        print("Veggie: \(self.veggieProduct)")
        print("Patties: \(self.patties)")
        print("Pickles: \(self.pickles)")
        print("Mayo: \(self.mayo)")
        print("Ketchup: \(self.ketchup)")
        print("Lettuce: \(self.lettuce)")
        print("Cook: \(self.cook.rawValue)")
    }
    
}
