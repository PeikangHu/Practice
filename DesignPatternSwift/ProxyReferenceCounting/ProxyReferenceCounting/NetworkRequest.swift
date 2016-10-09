//
//  NetworkRequest.swift
//  ProxyReferenceCounting
//
//  Created by Peikang Hu on 10/8/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol NetworkConnection
{
    func connect()
    func disconnect()
    func sendCommand(command:String)
}

class NetworkConnectionFactory
{
    class func createNetworkConnection() -> NetworkConnection
    {
        return connectionProxy
    }
    
    private class var connectionProxy:NetworkConnection
    {
        get
        {
            struct singletonWrapper
            {
                static let singleton = NetworkRequestProxy()
            }
            
            return singletonWrapper.singleton
        }
    }
}

class NetworkRequestProxy: NetworkConnection
{
    private let wrappedRequest: NetworkConnection
    private let queue = DispatchQueue(label: "commandQ")
    private var referenceCount:Int = 0
    private var connected = false
    
    init()
    {
        wrappedRequest = NetworkConnectionImplementation()
    }
    
    func connect() {
        // do nothing
    }
    
    func disconnect() {
        // do nothing
    }
    
    func sendCommand(command: String) {
        self.referenceCount += 1
        
        self.queue.sync {
            if (!self.connected && self.referenceCount > 0)
            {
                self.wrappedRequest.connect()
                self.connected = true
            }
            
            self.wrappedRequest.sendCommand(command: command)
            self.referenceCount -= 1
            
            if self.connected && self.referenceCount == 0
            {
                self.wrappedRequest.disconnect()
                self.connected = false
            }
        }
    }
    
}

fileprivate class NetworkConnectionImplementation: NetworkConnection
{
    typealias me = NetworkConnectionImplementation
    
    func connect() {
        me.writeMessage(msg: "Connect")
    }
    
    func disconnect() {
        me.writeMessage(msg: "Disconnect")
    }
    
    func sendCommand(command: String) {
        me.writeMessage(msg: "Command: \(command)")
        Thread.sleep(forTimeInterval: 1)
        me.writeMessage(msg: "Command completed: \(command)")
    }
    
    private class func writeMessage(msg:String)
    {
        self.queue.async {
            print(msg)
        }
    }
    
    private class var queue:DispatchQueue
    {
        get
        {
            struct singletonWrapper
            {
                static let singleton = DispatchQueue(label: "writeQ")
            }
            
            return singletonWrapper.singleton
        }
    }
}
