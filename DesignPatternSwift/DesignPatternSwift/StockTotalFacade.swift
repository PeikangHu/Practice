//
//  StockTotalFacade.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 10/7/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

// This is an opaque facade
class StockTotalFacade
{
    enum Currency
    {
        case USD
        case GBP
        case EUR
    }
    
    class func formatCurrencyAmount(amount:Double, currency:Currency) -> String?
    {
        var stfCurrency:StockTotalFactory.Currency
        
        switch currency
        {
            case .EUR:
                stfCurrency = StockTotalFactory.Currency.EUR
            case .GBP:
                stfCurrency = StockTotalFactory.Currency.GBP
            case .USD:
                stfCurrency = StockTotalFactory.Currency.USD
        }
        
        let factory = StockTotalFactory.getFactory(curr: stfCurrency)
        let totalAmount = factory.converter?.convertTotal(total: amount)
        
        if totalAmount != nil
        {
            let formattedValue = factory.formatter?.formatTotal(total: totalAmount!)
            if formattedValue != nil
            {
                return formattedValue!
            }
        }
        
        return nil
    }
}
