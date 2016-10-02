//
//  main.swift
//  AbstractFactory
//
//  Created by Peikang Hu on 9/28/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let factory = CarFactory.getFactory(car: Cars.SPORTS)

if factory != nil
{
    /* For not hide
    let car = Car(carType: .SPORTS,
                  floor: factory!.createFloorplan(),
                  suspension: factory!.createSuspension(),
                  drive: factory!.createDrivetrain())
    */
    
    let car = Car(carType: .SPORTS)
    car.printDetails()
}
