//
//  Bridge.swift
//  Bridge
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class CommunicatorBridge: ClearMessageChannel, SecureMessageChannel, PriorityMessageChannel
{
    private var channel:Channel
    
    init(channel:Channel.Channels)
    {
        self.channel = Channel.getChannel(channelType: channel)
    }
    
    func send(message:String)
    {
        let msg = ClearMessage(message:message)
        sendMessage(msg: msg)
    }
    
    func sendEncryptedMessage(encryptedText: String) {
        let msg = EncryptedMessage(message: encryptedText)
        sendMessage(msg: msg)
    }
    
    func sendPriority(message:String)
    {
        sendMessage(msg: PriorityMessage(message: message))
    }
    
    private func sendMessage(msg:Message)
    {
        msg.prepareMessage()
        channel.sendMessage(msg: msg)
    }
}
