//
//  main.swift
//  Builder
//
//  Created by Peikang Hu on 9/29/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

/*
let order = Burger(name: "Joe", veggie: false, patties: 2, pickles: true, mayo: true, ketchup: true, lettuce: true, cook: .NORMAL)
*/

// This is the builder to build the class
var builder = BurgerBuilder.getBuilder(burgerType: Burgers.BIGBURGER)

// Step 1 - Ask for name
let name = "Joe"

// Step 2 - Is veggie meal required?
builder.setVeggie(choice: false)

// Step 3 - Customize burger?
builder.setMayo(choice: false)
builder.setCooked(choice: Burger.Cooked.WELLDONE)

// Step 4 - Buy additional patty?
//builder.addPatty(choice: false)

let order = builder.buildObject(name: name)

order.printDescription()

/*
    The builder pattern in Cocoa
 
 */

var dateBuilder = NSDateComponents()

dateBuilder.hour = 10
dateBuilder.day = 6
dateBuilder.month = 9
dateBuilder.year = 1940
dateBuilder.calendar = Calendar.current

var date = dateBuilder.date

print(date!)
