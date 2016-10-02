//
//  Logger.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 9/19/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let productlogger = Logger<Product>(callback: {
    
    p in
    
    var builder = ChangeRecordBuilder()
    builder.productName = p.name
    builder.category  = p.category
    builder.value  = String(p.stockLevel)
    builder.outerTag = "stockChange"
    
    var changeRecord = builder.changeRecord
    if changeRecord != nil
    {
        print(builder.changeRecord!)
    }
    
})

// generic version of the class: 
// the Logger class can be used to store only objects that are derived from NSObject and implement the NSCopying protocol.
class Logger<T> where T:NSObject, T:NSCopying
{
    var dataItems:[T] = []
    var callback:(T) -> Void
    
    init(callback:@escaping (T) -> Void)
    {
        self.callback = callback
    }
    
    func logItem(item:T)
    {
        dataItems.append(item.copy() as! T)
        callback(item)
    }
    
    func processItems(callback:(T) -> Void)
    {
        for item in dataItems
        {
            callback(item)
        }
    }
}
