//
//  DataSourceBase.swift
//  Adapter
//
//  Created by Peikang Hu on 10/1/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class DataSourceBase: EmployeeDataSource
{
    var employees = [Employee]()
    
    func searchByName(name: String) -> [Employee] {
        return search(selector: {e -> Bool in
            return e.name.range(of: name) != nil
        })
    }
    
    func searchByTitle(title: String) -> [Employee] {
        return search(selector: {e -> Bool in
            return e.title.range(of: title) != nil
        })
    }
    
    private func search(selector:((Employee) -> Bool)) -> [Employee]
    {
        var results = [Employee]()
        
        for e in employees
        {
            if (selector(e))
            {
                results.append(e)
            }
        }
        
        return results
    }
}

class SalesDataSource: DataSourceBase
{
    override init()
    {
        super.init()
        
        employees.append(Employee(name: "Alice", title:"VP of Sales"))
        employees.append(Employee(name: "Bob", title:"Account Exec"))
    }
}

class DevelopmentDataSource: DataSourceBase
{
    override init()
    {
        super.init()
        
        employees.append(Employee(name:"Joe", title:"VP of Development"))
        employees.append(Employee(name:"Pepe", title:"Developer"))
        
    }
}
