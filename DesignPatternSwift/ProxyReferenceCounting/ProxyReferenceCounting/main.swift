//
//  main.swift
//  ProxyReferenceCounting
//
//  Created by Peikang Hu on 10/8/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let queue = DispatchQueue(label:"requestQ", attributes: .concurrent)

for count in 0 ..< 3
{
    let connection = NetworkConnectionFactory.createNetworkConnection()
    
    queue.async {
        connection.connect()
        connection.sendCommand(command: "Command: \(count)")
        connection.disconnect()
    }
}

let _ = FileHandle.standardInput.availableData


