//
//  NetworkConnection.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 9/24/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class NetworkConnection
{
    /* Change to flyweight
    private let stockData: [String: Int] =
        [
            "Kayak":10, "Lifejacket":14, "Soccer Ball":32, "Corner Flags": 1,
            "Stadium":4, "Thinking Cap":8, "Unsteady Chair":3,
            "Human Chess Board":2, "Bling-Bling King":4
        ]
    */
    
    private let flyweight:NetConnFlyweight
    
    init()
    {
        self.flyweight = NetConnFlyweightFactory.createFlyweight()
    }
    
    func getStockLevel(name:String) -> Int?
    {
        // Add a random delay of one second to some requests.
        Thread.sleep(forTimeInterval: Double(arc4random() % 2))
        //return stockData[name]
        
        return self.flyweight.getStockLevel(name: name)
    }
    
    func setStockLevel(name:String, level:Int)
    {
        print("Stock update: \(name) = \(level)")
    }
}
