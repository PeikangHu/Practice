//
//  Builder.swift
//  Builder
//
//  Created by Peikang Hu on 9/30/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

/*
    The first improvement is that it is possible to change a default value in the builder without
    having to make changes to the calling component or to the Burger class. If most customers choose not to have pickles, 
    then the restaurant can update its menu to make burgers without them. 
 
    The calling component is not aware that the default has changed, and neither is the Burger class,
    but Burger objects will now be created without pickles unless the customer specifically asks for them.
 
 
    The second improvement is that I can change or streamline the ordering process without needing to make changes
    in the builder or the Burger class.
 
    The third improvement is that I can change the Burger class and absorb the impact of the change in the builder class.
    
    The final improvement is that the builder class can be used to avoid inconsistent configurations that
    prevent an object from being created.
 
 */

enum Burgers
{
    case STANDARD
    case BIGBURGER
    case SUPERVEGGIE
}

class BurgerBuilder
{
    fileprivate var veggie = false
    fileprivate var pickles = true
    fileprivate var mayo = true
    fileprivate var ketchup = true
    fileprivate var lettuce = true
    fileprivate var cooked = Burger.Cooked.NORMAL
    fileprivate var patties = 2
    
    fileprivate init()
    {
        // do nothing
    }
    
    func setVeggie(choice:Bool)
    {
        self.veggie = choice
        
        //avoid inconsistent configurations
        if (choice)
        {
            patties = 0
        }
    }
    
    func setPickles(choice:Bool)    { self.pickles = choice }
    func setMayo(choice:Bool)       { self.mayo = choice }
    func setKetchup(choice:Bool)    { self.ketchup = choice }
    func setLettuce(choice:Bool)    { self.lettuce = choice }
    func setCooked(choice:Burger.Cooked)    { self.cooked = choice }
    
    func addPatty(choice: Bool)     { self.patties = choice ? 3:2 }
    
    func buildObject(name: String) -> Burger
    {
        return Burger(name: name, veggie: veggie, patties: patties, pickles: pickles, mayo: mayo, ketchup: ketchup, lettuce: lettuce, cook: cooked)
    }
        
    class func getBuilder(burgerType:Burgers) -> BurgerBuilder
    {
        let builder:BurgerBuilder
        
        switch burgerType
        {
            case .BIGBURGER: builder = BigBurgerBuilder()
            case .SUPERVEGGIE: builder = SuperVeggieBurgerBuilder()
            case .STANDARD: builder = BurgerBuilder()
        }
        
        return builder
    }
    
}


// define multiple builder classes that define different sets of default values and apply them through the factory method pattern.
class BigBurgerBuilder:BurgerBuilder
{
    fileprivate override init()
    {
        super.init()
        self.patties = 4
    }
    
    override func addPatty(choice:Bool)
    {
        fatalError("Cannot add patty to Big Burger")
    }
}

class SuperVeggieBurgerBuilder: BurgerBuilder
{
    fileprivate override init()
    {
        super.init()
        self.veggie = true
    }
    
    override func setVeggie(choice: Bool) {
        // do nothing - always veggie
    }
}




