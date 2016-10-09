//
//  Numbers.swift
//  Flyweight
//
//  Created by Peikang Hu on 10/8/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

func main()
{
    // NSNumber is a flyweight pattern. or string etc.
    let num1 = NSNumber(value: 10)
    let num2 = NSNumber(value: 10)
    
    print("Comparison: \(num1 == num2)")
    print("Identity: \(num1 === num2)")
    
    /*
     Comparison: true
     Identity: true
    */
}
