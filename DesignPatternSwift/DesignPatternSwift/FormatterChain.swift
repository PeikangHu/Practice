//
//  FormatterChain.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 10/9/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import UIKit

class CellFormatter
{
    var nextLink:CellFormatter?
    
    func formatCell(cell:ProductTableCell)
    {
        nextLink?.formatCell(cell: cell)
    }
    
    class func createChain() -> CellFormatter
    {
        let formatter = ChessFormatter()
        formatter.nextLink = WatersportsFormatter()
        formatter.nextLink?.nextLink = DefaultFomatter()
        return formatter
    }
}

class ChessFormatter:CellFormatter
{
    override func formatCell(cell: ProductTableCell) {
        if cell.product?.category == "Chess"
        {
            cell.backgroundColor = UIColor.lightGray
        }
        else
        {
            super.formatCell(cell: cell)
        }
    }
}

class WatersportsFormatter:CellFormatter
{
    override func formatCell(cell: ProductTableCell) {
        if cell.product?.category == "Watersports"
        {
            cell.backgroundColor = UIColor.green
        }
        else
        {
            super.formatCell(cell: cell)
        }
    }
}

class DefaultFomatter: CellFormatter
{
    override func formatCell(cell: ProductTableCell)
    {
        cell.backgroundColor = UIColor.yellow
    }
}
