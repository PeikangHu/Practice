//
//  Airplane.swift
//  Mediator
//
//  Created by Peikang Hu on 10/11/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

struct Position
{
    var distanceFromRunway:Int
    var height:Int
}

func == (lhs:Airplane, rhs:Airplane) -> Bool
{
    return lhs.name == rhs.name
}

class Airplane:MessagePeer // Peer
{
    var name:String
    var currentPosition:Position
    
    // Change it to mediator
    //private var otherPlanes:[Airplane]
    
    //var mediator:Mediator
    //var mediator:CommandMediator
    var mediator:MessageMediator
    
    let queue = DispatchQueue(label: "posQ", attributes:.concurrent)
    
    init(name:String, initialPos:Position, mediator:MessageMediator)
    {
        self.name = name
        self.currentPosition = initialPos
        
        self.mediator = mediator
        mediator.registerPeer(peer: self)
        //self.otherPlanes = [Airplane]()
    }
    
    /*
    func addPlanesInArea(planes:Airplane...)
    {
        for plane in planes
        {
            otherPlanes.append(plane)
        }
    }

    func otherPlaneDidLand(plane:Airplane)
    {
        if let index = otherPlanes.index(of: plane)
        {
            otherPlanes.remove(at: index)
        }
    }
    */
    
    func handleMessage(messageType: String, data: Any?) -> Any?
    {
        var result:Any?
        
        switch messageType {
        case "changePos":
            if let pos = data as? Position
            {
                result = otherPlaneDidChangePosition(position: pos)
            }
        default:
            fatalError("Unknown message type")
        }
        
        return result
    }
    
    func otherPlaneDidChangePosition(position:Position) -> Bool
    {
        var result = false
        
        self.queue.sync {
            result = position.distanceFromRunway == self.currentPosition.distanceFromRunway
                && abs(position.height - self.currentPosition.height) < 1000
        }
        
        return result
    }
    
    func changePosition(newPosition:Position)
    {
        self.queue.sync(flags: DispatchWorkItemFlags.barrier) {
            self.currentPosition = newPosition
            
            /*
            let c = Command(function: {peer in
                                            if let plane = peer as? Airplane
                                            {
                                                return plane.otherPlaneDidChangePosition(position: self.currentPosition)
                                            }
                                            else
                                            {
                                                fatalError("Type mismatch")
                                            }
                
                                        })
            */
            //let allResults = self.mediator.dispatchCommand(caller: self, command: c)
            
            let allResults = self.mediator.seendMessage(caller: self, messageType: "changePos", data: newPosition)
            
            for result in allResults
            {
                if result as? Bool == true
                {
                    print("\(self.name): Too close! Abort!")
                    return
                }
            }
            
            /*
            // rely on the meditator to manage the relationship with other peers on its behalf.
            if mediator.changePosition(peer: self, pos: self.currentPosition)
            {
                print("\(name): Too close! Abort!")
                return
            }
            */
            /*
             for plane in otherPlanes
             {
             if plane.otherPlaneDidChangePosition(plane: self)
             {
             print("\(name): Too close! Abort!")
             return
             }
             }
             */
            print("\(name): Position changed")
        }
    }
    
    func land()
    {
        self.queue.sync(flags: DispatchWorkItemFlags.barrier)
        {
            self.currentPosition = Position(distanceFromRunway: 0, height: 0)
            mediator.unregisterPeer(peer: self)
            /*
             for plane in otherPlanes
             {
             plane.otherPlaneDidLand(plane: self)
             }*/
            print("\(name): Landed")
        }
    }
}
