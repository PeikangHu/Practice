//
//  main.swift
//  Proxy
//
//  Created by Peikang Hu on 10/8/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let url = "http://www.apress.com"
let headers = ["Content-Length", "Content-Encoding"]

let proxy  = AccessControlProxy(url: url)

for header in headers
{
    proxy.getHeader(header: header)
    {
        (header, val) in
        
        if (val != nil)
        {
            print("\(header): \(val!)")
        }
    }
}

UserAuthentication.sharedInstance.authenticate(user: "bob", pass: "secret")

proxy.execute()

/*
let proxy = HttpHeaderRequestProxy()

for header in headers
{
    if let val = proxy.getHeader(url: url, header: header)
    {
        print("\(header):\(val)")
    }
}

let _ = FileHandle.standardInput.availableData
*/
