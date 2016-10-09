//
//  main.swift
//  ChainOfResp
//
//  Created by Peikang Hu on 10/9/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let messages = [
    Message(from: "bob@example.com", to: "joe@example.com",
            subject: "Free for lunch?"),
    Message(from: "joe@example.com", to: "alice@acme.com",
            subject: "New Contracts"),
    Message(from: "pete@example.com", to: "all@example.com",
            subject: "Priority: All-Hands Meeting"),
];

if let chain = Transmitter.createChain()
{
    for msg in messages
    {
        let handled = chain.sendMessage(message: msg)
        print("Message sent: \(handled)")
    }
}
