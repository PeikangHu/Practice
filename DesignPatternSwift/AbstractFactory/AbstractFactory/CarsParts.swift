//
//  CarsParts.swift
//  AbstractFactory
//
//  Created by Peikang Hu on 9/28/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

enum Cars:String
{
    case COMPACT = "VW Golf"
    case SPORTS = "Porsche Boxter"
    case SUV = "Cadillac Escalade"
}

struct Car
{
    var carType:Cars
    var floor:Floorplan
    var suspension:Suspension
    var drive:Drivetrain
    
    func printDetails()
    {
        print("Car type:\(carType.rawValue)")
        print("Seats: \(floor.seats)")
        print("Engine: \(floor.enginePosition.rawValue)")
        print("Suspension: \(suspension.suspensionType.rawValue)")
        print("Drive: \(drive.driveType.rawValue)")
    }
    
    // Hide the implementation of the abstract factory pattern.
    init(carType: Cars)
    {
        let concreteFactory = CarFactory.getFactory(car: carType)
        self.floor = concreteFactory!.createFloorplan()
        self.suspension = concreteFactory!.createSuspension()
        self.drive = concreteFactory!.createDrivetrain()
        
        self.carType = carType
    }
}
