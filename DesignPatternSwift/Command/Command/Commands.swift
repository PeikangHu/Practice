//
//  Commands.swift
//  Command
//
//  Created by Peikang Hu on 10/9/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol Command
{
    //func execute()
    
    //Changed for Macros
    func execute(receiver:Any)
}

class CommandWrapper: Command
{
    private let commands:[Command]
    
    init(commands:[Command])
    {
        self.commands = commands
    }
    
    // Changed for Macros
    func execute(receiver:Any)
    {
        for command in commands
        {
            command.execute(receiver: receiver)
        }
    }
    
    /*
    func execute()
    {
        for command in commands
        {
            command.execute()
        }
    }*/
}

class GenericCommand<T>:Command
{
    //private var receiver:T
    private var instructions:(T) -> Void
    
    init(instructions:@escaping (T) -> Void)
    {
        self.instructions = instructions
    }
    
    func execute(receiver: Any) {
        if let safeReceiver = receiver as? T
        {
            instructions(safeReceiver)
        }
        else
        {
            fatalError("Receiver is not expected type")
        }
    }
    
    class func createCommand(instructions:@escaping (T) -> Void) -> Command
    {
        return GenericCommand(instructions: instructions)
    }
    
    /*
    init(receiver:T, instructions:@escaping (T) -> Void)
    {
        self.receiver = receiver
        self.instructions = instructions
    }
    
    func execute()
    {
        instructions(receiver)
    }
    
    class func createCommand(receiver:T, instructions:@escaping (T) -> Void) -> Command
    {
        return GenericCommand(receiver: receiver, instructions: instructions)
    }
     */
}
