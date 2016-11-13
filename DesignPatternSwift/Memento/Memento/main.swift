//
//  main.swift
//  Memento
//
//  Created by Peikang Hu on 10/13/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let ledger = Ledger()

ledger.addEntry(counterParty: "Bob", amount: 100.43)
ledger.addEntry(counterParty: "Joe", amount: 200.20)

let memento = ledger.createMemento()

ledger.addEntry(counterParty: "Alice", amount: 500)
ledger.addEntry(counterParty: "Tony", amount: 20)

ledger.printEntries()

ledger.applyMemento(memento: memento)

ledger.printEntries()

