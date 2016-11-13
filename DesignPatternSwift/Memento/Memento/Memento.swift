//
//  Memento.swift
//  Memento
//
//  Created by Peikang Hu on 10/13/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol Memento
{
    // no methods or properties defined
}

protocol Originator
{
    func createMemento() -> Memento
    func applyMemento(memento:Memento)
}

