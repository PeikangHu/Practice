//
//  Orders.swift
//  Composite
//
//  Created by Peikang Hu on 10/5/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class CustomerOrder
{
    let customer:String
    let parts:[CarPart]

    init(customer:String, parts:[CarPart])
    {
        self.customer = customer
        self.parts = parts
    }
    
    var totalPrice:Float
    {
        return parts.reduce(0, { (subtotal, part) in
            return subtotal + part.price
        })
    }
    
    func printDetails()
    {
        print("Order for \(customer): Cost: \(formatCurrencyString(number: totalPrice))")
    }
    
    func formatCurrencyString(number:Float) -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return String(number)
    }

}
