//
//  Transmitters.swift
//  ChainOfResp
//
//  Created by Peikang Hu on 10/9/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class Transmitter
{
    var nextLink:Transmitter?
    
    required init() {}
    
    func sendMessage(message:Message) -> Bool
    {
        if nextLink != nil
        {
            return nextLink!.sendMessage(message: message)
        }
        else
        {
            print("End of chain reached. Message not sent")
            return false
        }
    }
    
    class func createChain() -> Transmitter?
    {
        let transmitterClasses:[Transmitter.Type] =
            [
                PriorityTransmitter.self,
                LocalTransmitter.self,
                RemoteTransmitter.self
            ]
        
        var link:Transmitter?
        
        for tClass in transmitterClasses.reversed()
        {
            let existingLink = link
            link = tClass.init()
            link?.nextLink = existingLink
        }
        
        return link
    }
    
    fileprivate class func matchEmailSuffix(message msg:Message) ->Bool
    {
        if let index = msg.from.characters.index(of: "@")
        {
            return msg.to.hasSuffix(msg.from[Range<String.Index>(uncheckedBounds:
                (lower: index, upper: msg.from.endIndex))])
        }
        
        return false
    }
}



class LocalTransmitter: Transmitter
{
    override func sendMessage(message:Message) -> Bool
    {
        if Transmitter.matchEmailSuffix(message: message)
        {
            print("Message to \(message.to) sent locally")
            return true
        }
        else
        {
            return super.sendMessage(message: message)
        }
    }
}

class RemoteTransmitter: Transmitter
{
    override func sendMessage(message:Message) -> Bool
    {
        if !Transmitter.matchEmailSuffix(message: message)
        {
            print("Message to \(message.to) sent remotely")
            return true
        }
        else
        {
            return super.sendMessage(message: message)
        }
    }
}

class PriorityTransmitter: Transmitter
{
    override func sendMessage(message: Message) -> Bool
    {
        if message.subject.hasPrefix("Priority")
        {
            print("Message to \(message.to) sent as priority")
            return true
        }
        else
        {
            return super.sendMessage(message: message)
        }
    }
}
