//
//  main.swift
//  Bridge
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

/* No bridge
var clearChannel = Landline()
var secureChannel = SecureLandLine()

var comms = Communicator(clearChannel: clearChannel, secureChannel: secureChannel)
*/

// It should be selected at compile time.
// By using a factory method to create Channel
var bridge = CommunicatorBridge(channel:Channel.Channels.Satellite)
var comms = Communicator(clearChannel: bridge, secureChannel: bridge, priorityChannel: bridge)

comms.sendCleartextMessage(message: "Hello!")
comms.sendSecureMessage(message: "This is a secret")
comms.sendPriorityMessage(message: "This is important")
