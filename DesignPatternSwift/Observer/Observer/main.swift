//
//  main.swift
//  Observer
//
//  Created by Peikang Hu on 10/12/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let log = ActivityLog()
let cache = FileCache()
let monitor = AttackMonitor()

let authM = AuthenticationManager()
authM.addObservers(observers: log, cache, monitor)

authM.authenticate(user: "bob", pass: "secret")
print("-----")
authM.authenticate(user: "joe", pass: "shhh")
