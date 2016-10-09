//
//  main.swift
//  Facade
//
//  Created by Peikang Hu on 10/6/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let facade = PirateFacade()
let prize = facade.getTreasure(type: .SHIP)

if (prize != nil)
{
    facade.crew.performAction(action: PirateCrew.Actions.DIVE_FOR_JEWELS, callback:
                                { secondPrice in
                                    print("Prize: \(prize!) pieces of eight")
                                }
                             )
}

