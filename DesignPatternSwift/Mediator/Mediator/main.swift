//
//  main.swift
//  Mediator
//
//  Created by Peikang Hu on 10/11/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

//let mediator:CommandMediator                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            = CommandMediator()

let mediator = MessageMediator()

// initial setup
let british = Airplane(name: "BA706", initialPos:Position(distanceFromRunway: 11, height:21000), mediator:mediator)

// new plane arrives
let american = Airplane(name: "AA101", initialPos: Position(distanceFromRunway: 12, height:22000), mediator: mediator)

// plane approaches airport
british.changePosition(newPosition: Position(distanceFromRunway: 8, height:10000))
british.changePosition(newPosition: Position(distanceFromRunway: 2, height:5000))
british.changePosition(newPosition: Position(distanceFromRunway: 1, height:1000))

// new plane arrives
let cathay = Airplane(name: "CX200", initialPos: Position(distanceFromRunway: 13, height:22000), mediator: mediator)

// plane lands
british.land()

// plane moves too close
cathay.changePosition(newPosition: Position(distanceFromRunway: 12, height:22000))
