//
//  Calculator.swift
//  Command
//
//  Created by Peikang Hu on 10/9/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class Calculator
{
    private(set) var total = 0
    
    // by using closure
    typealias CommandClosure = ((Calculator) -> Void)   // define an alias for use in arrays.
    private var history = [CommandClosure]()
    
    //private var history = [Command]()
    
    private var queue = DispatchQueue(label: "arrayQ")
    private var performingUndo = false
    
    func add(amount:Int)
    {
        
        //addUndoCommand(method: Calculator.subtract, amount: amount)
        addMacro(method: Calculator.add, amount:amount)
        total += amount
    }
    
    func subtract(amount:Int)
    {
        //addUndoCommand(method: Calculator.add, amount: amount)
        addMacro(method: Calculator.subtract, amount:amount)
        total -= amount
    }
    
    func multiply(amount:Int)
    {
        //addUndoCommand(method: Calculator.divide, amount: amount)
        addMacro(method: Calculator.multiply, amount: amount)
        total = total * amount
    }
    
    func divide(amount:Int)
    {
        //addUndoCommand(method: Calculator.multiply, amount: amount)
        addMacro(method: Calculator.divide, amount: amount)
        total = total / amount
    }
    
    private func addMacro(method:@escaping (Calculator) -> (Int) -> Void, amount:Int)
    {
        self.queue.sync {
            self.history.append({ calc in method(calc)(amount)})
        }
    }
    
    func getMacroCommand() -> ((Calculator) -> Void)
    {
        var commands = [CommandClosure]()
        
        queue.sync {
            commands = self.history
        }
        
        return
        {
            calc in
            
            if commands.count > 0
            {
                for index in 0..<commands.count
                {
                    commands[index](calc)
                }
            }
        }
    }
    
    /*
    // The Calculator object itself is not included in the Command objects that are created and subsequently
    // packaged up by the getMacroCommand method. 
    // Each command contains details of the operation method that will be invoked and the argument that will be passed to it.
    // And it is the responsibility of the calling component to specify the Calculator object that will be the receiver for the commands.
    private func addMacro(method:@escaping (Calculator) -> (Int) -> Void, amount:Int)
    {
        self.queue.sync {
            self.history.append(GenericCommand<Calculator>.createCommand
                {
                    calc in
                    method(calc)(amount)
                })
        }
    }
    
    func getMacroCommand() -> Command?
    {
        var command:Command?
        
        queue.sync {
            command = CommandWrapper(commands: self.history)
        }
        
        return command
    }
    */
    /*
    private func addUndoCommand(method:@escaping (Calculator) -> (Int) -> Void, amount:Int)
    {
        if !performingUndo
        {
            self.queue.sync
            {
                self.history.append(GenericCommand<Calculator>.createCommand(receiver: self, instructions:
                    { calc in
                        method(calc)(amount)
                }))
            }
        }
        
    }
    
    func undo()
    {
        self.queue.sync
        {
            if self.history.count > 0
            {
                self.performingUndo = true
                self.history.removeLast().execute()
                // temporary measure - executing the command adds to the history
                //self.history.removeLast()
                self.performingUndo = false
            }
        }
    }
    
    func getHistorySnapshot() -> Command?
    {
        var command:Command?
        
        queue.sync
        {
            command  = CommandWrapper(commands: self.history.reversed())
        }
        
        return command
    }
    */
}
