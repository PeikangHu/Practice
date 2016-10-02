//
//  main.swift
//  FactoryMethod
//
//  Created by Peikang Hu on 9/25/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let passengers = [1,3,5]

for p in passengers
{
    print("\(p) passengers: \(CarSelector.selectCar(passengers: p)!)")
}

