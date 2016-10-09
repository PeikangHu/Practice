//
//  CopyOnWrite.swift
//  Flyweight
//
//  Created by Peikang Hu on 10/8/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class Owner: NSObject, NSCopying
{
    var name:String
    var city:String
    
    init(name:String, city:String)
    {
        self.name = name
        self.city = city
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        print("Copy")
        return Owner(name:self.name, city:self.city)
    }
}

class FlyweightFactory1
{
    class func createFlyweight() -> Flyweight1
    {
        return Flyweight1(owner: ownerSingleton)
    }
    
    private class var ownerSingleton:Owner
    {
        get
        {
            struct singletonWrapper
            {
                static let singleton = Owner(name:"Anonymous", city:"Anywhere")
            }
            
            return singletonWrapper.singleton
        }
    }
}

class Flyweight1
{
    private let extrinsicOwner:Owner
    private var intrinsicOwner:Owner?
    
    init(owner:Owner)
    {
        self.extrinsicOwner = owner
    }
    
    var name:String
    {
        get
        {
            return intrinsicOwner?.city ?? extrinsicOwner.city
        }
        
        set (value)
        {
            decoupleFromExtrinsic()
            intrinsicOwner?.city = value
        }
    }
    
    private func decoupleFromExtrinsic()
    {
        if intrinsicOwner == nil
        {
            intrinsicOwner = extrinsicOwner.copy(with: nil) as? Owner
        }
    }
}
