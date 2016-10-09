//
//  main.swift
//  Composite
//
//  Created by Peikang Hu on 10/5/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let doorWindow = CompositePart(name: "DoorWindow", parts:
                                        Part(name:"Window", price: 100.5),
                                        Part(name:"Window Switch", price: 12)
                               )

let door = CompositePart(name: "Door", parts:
                            doorWindow,
                            Part(name:"Door Loom", price: 80),
                            Part(name:"Window Switch", price:12),
                            Part(name:"Door Handles", price:43.4)
                        )

let hood = Part(name: "Hood", price: 320)

let order = CustomerOrder(customer: "Bob", parts: [hood, door, doorWindow])
order.printDetails()

