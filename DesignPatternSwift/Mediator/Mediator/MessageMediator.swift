//
//  MessageMediator.swift
//  Mediator
//
//  Created by Peikang Hu on 10/12/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol MessagePeer
{
    var name:String {get}
    func handleMessage(messageType:String, data:Any?) -> Any?
}

class MessageMediator
{
    private var peers = [String:MessagePeer]()
    
    func registerPeer(peer:MessagePeer)
    {
        peers[peer.name] = peer
    }
    
    func unregisterPeer(peer:MessagePeer)
    {
        peers.removeValue(forKey: peer.name)
    }
    
    func seendMessage(caller:MessagePeer, messageType:String, data:Any) -> [Any?]
    {
        var results = [Any?]()
        
        for peer in peers.values
        {
            if peer.name != caller.name
            {
                results.append(peer.handleMessage(messageType: messageType, data: data))
            }
        }
        return results
    }
}
