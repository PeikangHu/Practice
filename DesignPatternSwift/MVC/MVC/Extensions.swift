//
//  Extensions.swift
//  MVC
//
//  Created by Peikang Hu on 10/16/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

extension String
{
    func split() -> [String]
    {
        return self.components(separatedBy: CharacterSet.whitespacesAndNewlines).filter({$0 != ""})
    }
}

extension Array
{
    func unique<T: Equatable>() -> [T]
    {
        var uniqueValues = [T]()
        
        for value in self
        {
            if !uniqueValues.contains(value as! T)
            {
                uniqueValues.append(value as! T)
            }
        }
        
        return uniqueValues
    }
    
    func first<T>(test:(T) -> Bool) -> T?
    {
        for value in self
        {
            if test(value as! T)
            {
                return value as? T
            }
        }
        
        return nil
    }
}



