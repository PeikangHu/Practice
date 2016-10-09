//
//  PirateShip.swift
//  Facade
//
//  Created by Peikang Hu on 10/6/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class PirateShip
{
    struct ShipLocation
    {
        let NorthSouth:Int
        let EastWest:Int
    }
    
    var currentPosition:ShipLocation
    var movementQueue = DispatchQueue(label: "shipQ")
    
    init()
    {
        currentPosition = ShipLocation(NorthSouth: 5, EastWest: 5)
    }
    
    func moveToLocation(location:ShipLocation, callback:@escaping (ShipLocation) -> Void)
    {
        movementQueue.async {
            self.currentPosition = location
            callback(self.currentPosition)
        }
    }
    
    
}
