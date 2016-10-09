//
//  Spreadsheet.swift
//  Flyweight
//
//  Created by Peikang Hu on 10/7/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

func  == (lhs:Coordinate, rhs:Coordinate) -> Bool
{
    return lhs.col == rhs.col && lhs.row == rhs.row
}

class Coordinate:Hashable, CustomStringConvertible
{
    let col:Character
    let row:Int
    
    init(col:Character, row:Int)
    {
        self.col = col
        self.row = row
    }
    
    var hashValue: Int
    {
        return description.hashValue
    }
    
    var description:String
    {
        return "\(col)\(row)"
    }
    
}

class Cell
{
    var coordinate:Coordinate
    var value:Int
    
    init(col:Character, row:Int, val:Int)
    {
        self.coordinate = Coordinate(col:col, row:row)
        self.value = val
    }
}

class Spreadsheet
{
    var grid:Flyweight
    
    init()
    {
        grid = FlyweightFactory.createFlyweight()
    }
    
    func setValue(coord:Coordinate, value:Int)
    {
        grid[coord] = value
    }
    
    var total:Int
    {
        return grid.total
    }
}

/* Not flyweight
class Spreadsheet
{
    var grid = Dictionary<Coordinate, Cell>()
    
    init()
    {
        let letters:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var stringIndex = letters.startIndex
        let rows = 50
        
        repeat
        {
            let colLetter = letters[stringIndex]
            stringIndex = letters.index(after: stringIndex)
            
            for rowIndex in 1...rows
            {
                let cell = Cell(col: colLetter, row: rowIndex, val: rowIndex)
                grid[cell.coordinate] = cell
            }
        }
        while (stringIndex != letters.endIndex)
    }
    
    func setValue(coord:Coordinate, value:Int)
    {
        grid[coord]?.value = value
    }
    
    var total:Int
    {
        return grid.values.reduce(0, {total, cell in return total + cell.value})
    }
}
 */
