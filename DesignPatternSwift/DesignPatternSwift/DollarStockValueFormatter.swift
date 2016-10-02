//
//  StockValueImplementations.swift
//  AbstractFactory
//
//  Created by Peikang Hu on 9/29/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol StockValueFormatter {
    func formatTotal(total: Double) -> String
}

class DollarStockValueFormatter: StockValueFormatter
{
    func formatTotal(total: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: total)
        return "\(formatted)"
    }
}

class PoundStockValueFormatter:StockValueFormatter
{
    func formatTotal(total: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: total)
    
        return "£\(String(formatted.characters.dropFirst()))"
    }
}

protocol StockValueConverter
{
    func convertTotal(total:Double) -> Double
}

class DollarStockValueConverter: StockValueConverter
{
    func convertTotal(total: Double) -> Double {
        return total
    }
}

class PoundStockValueConverter: StockValueConverter
{
    func convertTotal(total: Double) -> Double {
        return 0.60338 * total
    }
}
