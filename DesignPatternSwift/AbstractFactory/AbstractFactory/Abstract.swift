//
//  Abstract.swift
//  AbstractFactory
//
//  Created by Peikang Hu on 9/28/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class CarFactory
{
    // Apply Singleton Pattern
    required init()
    {
        // Do nothing
    }
    
    func createFloorplan() -> Floorplan
    {
        fatalError("Not implemented")
    }
    
    func createSuspension() -> Suspension
    {
        fatalError("Not implemented")
    }
    
    func createDrivetrain() -> Drivetrain
    {
        fatalError("Not implemented")
    }
    
    final class func getFactory(car:Cars) -> CarFactory?
    {
        var factoryType:CarFactory.Type
        
        switch car {
        case .COMPACT:
            factoryType = CompactCarFactory.self
        case .SPORTS:
            factoryType = SportsCarFactory.self
        case .SUV:
            factoryType = SUVCarFactory.self
        }
        
        var factory = factoryType.sharedInstance
        
        if factory == nil
        {
            factory = factoryType.init()
        }
        
        return factory
    }
    
    class var sharedInstance:CarFactory?
    {
        get
        {
            return nil
        }
    }
    
    /* For not Singleton
    final class func getFactory(car:Cars) -> CarFactory?
    {
        var factory: CarFactory?
        
        switch car {
        case .COMPACT:
            factory = CompactCarFactory()
        case .SPORTS:
            factory = SportsCarFactory()
        case .SUV:
            factory = SUVCarFactory()
        }
        
        return factory
    }*/
}
