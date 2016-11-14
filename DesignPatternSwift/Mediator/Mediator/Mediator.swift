//
//  Mediator.swift
//  Mediator
//
//  Created by Peikang Hu on 10/11/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol Peer {
    var name:String {get}
    var currentPosition:Position {get}
    func otherPlaneDidChangePosition(position:Position) -> Bool
}

protocol Mediator
{
    func registerPeer(peer:Peer)
    func unregisterPeer(peer:Peer)
    func changePosition(peer:Peer, pos:Position) -> Bool
}

class AirplaneMediator: Mediator
{
    private var peers:[String:Peer]
    
    private let queue = DispatchQueue(label:"dictQ", attributes: .concurrent)
    
    init()
    {
        peers = [String:Peer]()
    }
    
    func registerPeer(peer: Peer) {
        
        self.queue.sync(flags: DispatchWorkItemFlags.barrier)
        {
            self.peers[peer.name] = peer
        }
    }
    
    func unregisterPeer(peer: Peer)
    {
        self.queue.sync(flags: DispatchWorkItemFlags.barrier)
        {
            let _ = self.peers.removeValue(forKey: peer.name)
        }
    }
    
    func changePosition(peer: Peer, pos: Position) -> Bool
    {
        var result = false
        
        self.queue.sync
        {
            
            // Add more logic into the mediator, filter out those that are farther away from the airport.
            let closerPeers = self.peers.values.filter({p in return p.currentPosition.distanceFromRunway <= pos.distanceFromRunway})

            
            for storedPeer in closerPeers //peers.values
            {
                if peer.name != storedPeer.name && storedPeer.otherPlaneDidChangePosition(position: pos)
                {
                    result = true
                }
            }
        }
        
        return result
    }
}
