//
//  DoubleDispatch.swift
//  Visitor
//
//  Created by Peikang Hu on 10/15/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

// Calling the handle method from within an objects method has the effect of calling the method version
// with the most specific argument type without needing to perform any casts, which is the central technique
// in the visitor pattern.
func main()
{
    let objects:[MyProtocol] = [FirstClass(), SecondClass()]
    let handler = Handler()
    
    for object in objects
    {
        /*
        //Protocol
        //Protocol
        handler.handle(arg: object)
        */
        
        /*
         First Class
         Second Class
         */
        object.dispatch(handler: handler)
    }
}

protocol MyProtocol
{
    func dispatch(handler:Handler)
}

class FirstClass:MyProtocol
{
    func dispatch(handler: Handler)
    {
        handler.handle(arg: self)
    }
}

class SecondClass:MyProtocol
{
    func dispatch(handler: Handler)
    {
        handler.handle(arg: self)
    }
}

class Handler
{
    func handle(arg:MyProtocol)
    {
        print("Protocol")
    }
    
    func handle(arg:FirstClass)
    {
        print("First Class")
    }
    
    func handle(arg:SecondClass)
    {
        print("Second Class")
    }
}
