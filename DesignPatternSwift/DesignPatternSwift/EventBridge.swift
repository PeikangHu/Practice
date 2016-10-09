//
//  EventBridge.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class EventBridge
{
    private let outputCallback:(String, Int) -> Void
    
    init(callback:@escaping (String, Int) -> Void)
    {
        self.outputCallback = callback
    }
    
    var inputCallback:(Product) -> Void
    {
        return { p in self.outputCallback(p.name, p.stockLevel)}
    }
}
