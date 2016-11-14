//
//  Ledger.swift
//  Memento
//
//  Created by Peikang Hu on 10/13/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

/*
class LedgerEntry
{
    let id:Int
    let counterParty:String
    let amount:Float
    
    init(id:Int, counterParty:String, amount:Float)
    {
        self.id = id
        self.counterParty = counterParty
        self.amount = amount
    }
}


class LedgerMemento:Memento
{
    private var entries = [LedgerEntry]()
    private let total:Float
    private let nextId:Int
    
    init(ledger:Ledger)
    {
        self.entries = [LedgerEntry](ledger.entries.values)
        self.total = ledger.total
        self.nextId = ledger.nextId
    }
    
    func apply(ledger:Ledger)
    {
        ledger.total = self.total
        ledger.nextId = self.nextId
        ledger.entries.removeAll(keepingCapacity: true)
        
        for entry in self.entries
        {
            ledger.entries[entry.id] = entry
        }
    }
}

class Ledger: Originator
{
    fileprivate var entries = [Int:LedgerEntry]()
    fileprivate var nextId = 1
    
    var total:Float = 0
    
    func addEntry(counterParty:String, amount:Float)
    {
        nextId += 1
        let entry = LedgerEntry(id: nextId, counterParty: counterParty, amount:amount)
        entries[entry.id] = entry
        
        total += amount
    }
    
    func createMemento() -> Memento {
        return LedgerMemento(ledger: self)
    }
    
    func applyMemento(memento: Memento) {
        if let m = memento as? LedgerMemento
        {
            m.apply(ledger: self)
        }
    }
    
    func printEntries()
    {
        for id in entries.keys.sorted(by: <)
        {
            if let entry = entries[id]
            {
                print("#\(id): \(entry.counterParty) $\(entry.amount)")
            }
        }
        
        print("Total: $\(total)")
        print("----")
    }
}
 */
