//
//  Concrete.swift
//  AbstractFactory
//
//  Created by Peikang Hu on 9/28/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class CompactCarFactory: CarFactory
{
    override func createFloorplan() -> Floorplan {
        return StandardFloorplan()
    }
    
    override func createSuspension() -> Suspension {
        return RoadSuspension.getInstance()
    }
    
    override func createDrivetrain() -> Drivetrain {
        return FrontWheelDrive()
    }
}

class SportsCarFactory: CarFactory
{
    override func createFloorplan() -> Floorplan {
        return ShortFloorplan()
    }
    
    override func createSuspension() -> Suspension {
        return RaceSuspension.getInstance()
    }
    
    override func createDrivetrain() -> Drivetrain {
        return RearWheelDrive()
    }
    
    override class var sharedInstance:CarFactory?
    {
        get
        {
            struct SingletonWrapper
            {
                static let singleton = SportsCarFactory()
            }
            
            return SingletonWrapper.singleton 
        }
    }
}

class SUVCarFactory: CarFactory
{
    override func createFloorplan() -> Floorplan {
        return LongFloorplan()
    }
    
    override func createSuspension() -> Suspension {
        return OffRoadSuspension.getInstance()
    }
    
    override func createDrivetrain() -> Drivetrain {
        return AllWheelDrive()
    }
}
