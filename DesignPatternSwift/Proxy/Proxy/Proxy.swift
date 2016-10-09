//
//  Proxy.swift
//  Proxy
//
//  Created by Peikang Hu on 10/8/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

/*
    1. Using the Remote Object Proxy
    2. Implementing the Expensive Operation Porxy
    3. Deferring the Operation
 
 */

protocol HttpHeaderRequest
{
    init(url:String)
    func execute()
    
    func getHeader(header:String, callback:@escaping (String, String?) -> Void)
}

class AccessControlProxy: HttpHeaderRequest
{
    private let wrappedObject: HttpHeaderRequest
    
    required init(url:String)
    {
        wrappedObject = HttpHeaderRequestProxy(url:url)
    }
    
    func getHeader(header: String, callback: @escaping (String, String?) -> Void) {
        wrappedObject.getHeader(header: header, callback: callback)
    }
    
    func execute()
    {
        if (UserAuthentication.sharedInstance.authenticated)
        {
            wrappedObject.execute()
        }
        else
        {
            fatalError("Unauthorized")
        }
    }
}

fileprivate class HttpHeaderRequestProxy: HttpHeaderRequest
{
    let url:String
    var headerRequired:[String: (String, String?) -> Void]
    
    required init(url:String)
    {
        self.url = url
        self.headerRequired = Dictionary<String, (String, String?) -> Void>()
    }
    
    func getHeader(header:String, callback:@escaping (String, String?) -> Void)
    {
        self.headerRequired[header] = callback;
    }
    
    func execute()
    {
        let nsUrl = URL(string: url)
        let request = URLRequest(url: nsUrl!)
        
        URLSession.shared.dataTask(with: request,
                                   completionHandler:
            {
                (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse
                {
                    let headers = httpResponse.allHeaderFields as! [String:String]
                    
                    for (header, callback) in self.headerRequired
                    {
                        callback(header, headers[header])
                    }
                }
        }).resume()
        
    }
    
    
}

/* 

 1. Using the Remote Object Proxy
 2. Implementing the Expensive Operation Porxy

 protocol HttpHeaderRequest
 {
     init(url:String)
     func execute()
     
     func getHeader(url:String, header:String) -> String?
 }
 
 class HttpHeaderRequestProxy: HttpHeaderRequest
{
    private let queue = DispatchQueue(label: "httpQ")
    private var cachedHeaders = [String:String]()
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    func getHeader(url: String, header: String) -> String?
    {
        var headerValue:String?
        
        self.queue.sync {
            if let cachedValue = self.cachedHeaders[header]
            {
                headerValue = "\(cachedValue) (cached)"
            }
            else
            {
                let nsUrl = URL(string: url)
                let request = URLRequest(url: nsUrl!)
                
                URLSession.shared.dataTask(with: request, completionHandler:
                    {
                        data, response, error in
                        
                        if let httpResponse = response as? HTTPURLResponse
                        {
                            let headers = httpResponse.allHeaderFields as! [String: String]
                            
                            for (name, value) in headers
                            {
                                self.cachedHeaders[name] = value
                            }
                            
                            headerValue = httpResponse.allHeaderFields[header] as? String
                        }
                        
                        self.semaphore.signal()
                }).resume()
                let _ = self.semaphore.wait(timeout: .distantFuture)

            }
        }
        
        return headerValue

    }
}
*/
