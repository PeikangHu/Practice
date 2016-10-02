//
//  Utils.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 9/15/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class Utils
{
    class func currencyStringFromNumber(number:Double) -> String
    {
        let formatter = NumberFormatter();
        formatter.numberStyle = .currency;
        return formatter.string(from: NSNumber(value:number)) ?? "";
    }
}
