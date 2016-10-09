//
//  main.swift
//  Decorator
//
//  Created by Peikang Hu on 10/3/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let account = CustomerAccount(name: "Joe")

account.addPurchase(purchase: Purchase(product: "Red Hat", price: 10))
account.addPurchase(purchase: Purchase(product: "Scarf", price: 20))

account.addPurchase(purchase: EndOfLineDecorator(purchase:
                              BlackFridayDecorator(purchase:
                              PurchaseWithDelivery(purchase: Purchase(product: "Sunglasses", price: 25)))))

account.printAccount()

for p in account.purchases
{
    if let d = p as? DiscountDecorator
    {
        print("\(p) has \(d.countDiscounts()) discounts")
    }
    else
    {
        print("\(p) has no discounts")
    }
}
