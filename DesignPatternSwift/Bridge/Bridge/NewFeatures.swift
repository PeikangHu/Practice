//
//  NewFeatures.swift
//  Bridge
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class SatelliteChannel: Channel
{
    override func sendMessage(msg: Message) {
        print("Satellite: \(msg.contentToSend)")
    }
}

class PriorityMessage:ClearMessage
{
    override var contentToSend: String
    {
        return "Important: \(super.contentToSend)"
    }
}
