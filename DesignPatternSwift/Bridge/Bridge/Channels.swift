//
//  Channels.swift
//  Bridge
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

// Applying Factory Method Pattern
class Channel
{
    enum Channels
    {
        case Landline
        case Wireless
        case Satellite
    }

    class func getChannel(channelType:Channels) -> Channel
    {
        switch channelType
        {
        case .Landline:
            return LandlineChannel()
        case .Wireless:
            return WirelessChannel()
        case .Satellite:
            return SatelliteChannel()
        }
    }
    
    func sendMessage(msg:Message)
    {
        fatalError("Not implemented")
    }
}


class LandlineChannel: Channel
{
    override func sendMessage(msg:Message)
    {
        print("Landline: \(msg.contentToSend)")
    }
}

class WirelessChannel: Channel
{
    override func sendMessage(msg: Message) {
        print("Wireless: \(msg.contentToSend)")
    }
}

/*
protocol Channel
{
    func sendMessage(msg:Message)
}

class LandlineChannel: Channel
{
    func sendMessage(msg:Message)
    {
        print("Landline: \(msg.contentToSend)")
    }
}

class WirelessChannel: Channel
{
    func sendMessage(msg: Message) {
        print("Wireless: \(msg.contentToSend)")
    }
}
*/

/* Without bridge
class Landline: ClearMessageChannel
{
    func send(message:String)
    {
        print("Landline: \(message)")
    }
}

class SecureLandLine: SecureMessageChannel
{
    func sendEncryptedMessage(encryptedText message: String)
    {
        print("Secure Landline: \(message)")
    }
}

class Wireless: ClearMessageChannel
{
    func send(message: String)
    {
        print("Wireless: \(message)")
    }
}

class SecureWireless: SecureMessageChannel
{
    func sendEncryptedMessage(encryptedText message: String) {
        print("Secure Wireless: \(message)")
    }
}

*/



