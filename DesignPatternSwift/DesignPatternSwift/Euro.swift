//
//  Euro.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

// EuroHandler does not fit directly into the model that the application expects and so requires an adapter.
class EuroHandler
{
    func getDisplayString(amount:Double) -> String
    {
        let formatted = Utils.currencyStringFromNumber(number: amount)
        return "€\(String(formatted.characters.dropFirst()))"
    }
    
    func getCurrencyAmount(amount:Double) -> Double
    {
        return 0.76164 * amount
    }
}
