//
//  CustomerAccount.swift
//  Decorator
//
//  Created by Peikang Hu on 10/3/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class CustomerAccount
{
    let customerName:String
    var purchases = [Purchase]()
    
    init(name:String)
    {
        self.customerName = name
    }
    
    func addPurchase(purchase:Purchase)
    {
        self.purchases.append(purchase)
    }
    
    func printAccount()
    {
        var total:Float = 0
        for p in purchases
        {
            total += p.totalPrice
            print("Purchase \(p), Price \(formatCurrencyString(number: p.totalPrice))")
        }
        
        print("Total due: \(formatCurrencyString(number: total))")
    }
    
    func formatCurrencyString(number:Float) -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from:NSNumber(value:number)) ?? ""
    }
}
