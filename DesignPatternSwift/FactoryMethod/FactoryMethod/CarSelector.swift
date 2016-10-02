//
//  CarSelector.swift
//  FactoryMethod
//
//  Created by Peikang Hu on 9/25/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class CarSelector
{
    class func selectCar(passengers:Int) -> String?
    {
        return RentalCar.createRentalCar(passengers: passengers)?.name
    }
} 
