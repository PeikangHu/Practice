//
//  PriceCalculator.swift
//  FactoryMethod
//
//  Created by Peikang Hu on 9/25/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class PriceCalculator
{
    class func calculatePrice(passengers:Int, days:Int) -> Float?
    {
        let car  = RentalCar.createRentalCar(passengers: passengers)
        return car == nil ? nil : car!.pricePerDay * Float(days)
    }
}
