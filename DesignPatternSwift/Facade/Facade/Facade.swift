//
//  Facade.swift
//  Facade
//
//  Created by Peikang Hu on 10/6/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

enum TreasureTypes
{
    case SHIP
    case BURIED
    case SUNKEN
}

class PirateFacade
{
    // No private means transparent facade.
    let map = TreasureMap()
    let ship = PirateShip()
    let crew = PirateCrew()
    
    func getTreasure(type:TreasureTypes) -> Int?
    {
        var prizeAmount:Int?
        
        // select the treasure type
        var treasureMapType:TreasureMap.Treasures
        var crewWorkType:PirateCrew.Actions
        
        switch type
        {
            case .SHIP:
                treasureMapType = TreasureMap.Treasures.GALLEON
                crewWorkType = PirateCrew.Actions.ATTACK_SHIP
            case .BURIED:
                treasureMapType = TreasureMap.Treasures.BURIED_GOLD
                crewWorkType = PirateCrew.Actions.DIG_FOR_GOLD
            case .SUNKEN:
                treasureMapType = TreasureMap.Treasures.SUNKEN_JEWELS
                crewWorkType = PirateCrew.Actions.DIVE_FOR_JEWELS
        }
        
        let treasureLocation = map.findTreasure(type: treasureMapType)
        
        // convert from map to ship coordinates
        let sequence:[Character] = ["A", "B", "C", "D", "E", "F", "G"]
        let eastWestPos = sequence.index(of: treasureLocation.gridLetter)
        let shipTarget = PirateShip.ShipLocation(NorthSouth: Int(treasureLocation.gridNumber), EastWest: eastWestPos!)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        // relocate ship
        ship.moveToLocation(location: shipTarget, callback: {
            (location) in
            self.crew.performAction(action: crewWorkType, callback: { prize in
                prizeAmount = prize
                semaphore.signal()
            })
        })
        
        semaphore.wait(timeout: .distantFuture)
        return prizeAmount
    }
}
