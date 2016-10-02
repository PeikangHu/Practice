//
//  Suspension.swift
//  AbstractFactory
//
//  Created by Peikang Hu on 9/28/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

@objc protocol Suspension
{
    var suspensionType:SuspensionOption { get }
    
    static func getInstance() -> Suspension
}

/*
enum SuspensionOption:String
{
    case STANDARD = "Standard"
    case SPORTS = "Firm"
    case SOFT = "Soft"
}
*/
 
class RoadSuspension: Suspension
{
    var suspensionType = SuspensionOption.STANDARD
    
    private init() {}
    
    class func getInstance() -> Suspension {
        return RoadSuspension()
    }
}

class OffRoadSuspension: Suspension
{
    var suspensionType = SuspensionOption.SOFT
    
    private init() {}
    
    class func getInstance() -> Suspension {
        return OffRoadSuspension()
    }
    
}
// This is Prototype Pattern to copy an instance every time.
class RaceSuspension: NSObject, NSCopying, Suspension
{
    var suspensionType = SuspensionOption.SPORTS
    
    private override init() {}
    
    private class var prototype:RaceSuspension
    {
        get
        {
            struct SingletonWrapper
            {
                static let singleton = RaceSuspension()
            }
            
            return SingletonWrapper.singleton
        }
    }
    
    class func getInstance() -> Suspension {
        return prototype.copy() as! Suspension
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return RaceSuspension()
    }
}

/*
class RaceSuspension:Suspension
{
    var suspensionType = SuspensionOption.SPORTS
}
*/
