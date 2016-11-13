//
//  main.swift
//  TemplateMethod
//
//  Created by Peikang Hu on 10/15/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let donorDb = DonorDatabase()

let galaInvitations = donorDb.generate(maxNumber:2)

for invite in galaInvitations
{
    print(invite)
}

donorDb.filter = { $0.filter({ $0.lastDonation == 0 })}
donorDb.generate = { $0.map({ "Hi \($0.firstName)" }) }

let newDonors = donorDb.generate(maxNumber:Int.max)

for invite in newDonors
{
    print(invite)
}
