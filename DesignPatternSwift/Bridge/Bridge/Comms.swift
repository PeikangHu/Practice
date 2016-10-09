//
//  Comms.swift
//  Bridge
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol ClearMessageChannel
{
    func send(message:String)
}

protocol SecureMessageChannel {
    func sendEncryptedMessage(encryptedText:String)
}

protocol PriorityMessageChannel
{
    func sendPriority(message:String)
}

class Communicator
{
    private let clearChannel:ClearMessageChannel
    private let secureChannel:SecureMessageChannel
    private let priorityChannel:PriorityMessageChannel
    
    init(clearChannel:ClearMessageChannel,
         secureChannel:SecureMessageChannel,
         priorityChannel:PriorityMessageChannel)
    {
        self.clearChannel = clearChannel
        self.secureChannel = secureChannel
        self.priorityChannel = priorityChannel
    }
    
    func sendCleartextMessage(message:String)
    { 
        self.clearChannel.send(message: message)
    }
    
    func sendSecureMessage(message:String)
    {
        self.secureChannel.sendEncryptedMessage(encryptedText: message)
    }
    
    func sendPriorityMessage(message:String)
    {
        self.priorityChannel.sendPriority(message: message)
    }
}
