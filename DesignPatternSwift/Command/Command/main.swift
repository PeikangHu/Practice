//
//  main.swift
//  Command
//
//  Created by Peikang Hu on 10/9/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let calc = Calculator()
calc.add(amount: 10)
calc.multiply(amount: 4)
calc.subtract(amount: 2)

print("Calc 1 Total: \(calc.total)")

let macro = calc.getMacroCommand()

let calc2 = Calculator()
//macro?.execute(receiver: calc2)
macro(calc2)    // by using closure.

print("Calc 2 Total: \(calc2.total)")

/*
// Run a sequence of commands in once.
let snapshot = calc.getHistorySnapshot()
print("Pre-Snapshot Total: \(calc.total)")
snapshot?.execute()
print("Post-Snapshot Total: \(calc.total)")
*/

/*
print("Total: \(calc.total)")

for _ in 0..<3
{
    calc.undo()
    print("Undo called. Total: \(calc.total)")
}
*/
