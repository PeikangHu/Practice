//
//  Adapter.swift
//  Adapter
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

// Using Wrapper Class
class NewCoDirectoryAdapter: EmployeeDataSource
{
    private let directory:NewCoDirectory
    
    init()
    {
        directory = NewCoDirectory()
    }
    
    var employees:[Employee]
    {
        return directory.getStaff().values.map
            {
                sv -> Employee in
                return Employee(name: sv.getName(), title:sv.getJob())
        }
    }
    
    func searchByName(name: String) -> [Employee] {
        return createEmployees
            {
                sv -> Bool in
                return sv.getJob().range(of: name) != nil
        }
    }
    
    func searchByTitle(title: String) -> [Employee] {
        return createEmployees
            {
                sv -> Bool in
                return sv.getJob().range(of: title) != nil
        }
    }
    
    private func createEmployees(filter filterClousure:((NewCoStaffMember) -> Bool)) -> [Employee]
    {
        return directory.getStaff().values.map
            {
                entry -> Employee in
                return Employee(name: entry.getName(), title: entry.getJob())
        }
    }
}

/* By using extension
extension NewCoDirectory: EmployeeDataSource
{
    var employees:[Employee]
    {
        return getStaff().values.map
                {
                    sv -> Employee in
                        return Employee(name: sv.getName(), title:sv.getJob())
                }
    }
    
    func searchByName(name: String) -> [Employee] {
        return createEmployees
        {
            sv -> Bool in
                return sv.getJob().range(of: name) != nil
        }
    }
    
    func searchByTitle(title: String) -> [Employee] {
        return createEmployees
            {
                sv -> Bool in
                return sv.getJob().range(of: title) != nil
        }
    }
    
    private func createEmployees(filter filterClousure:((NewCoStaffMember) -> Bool)) -> [Employee]
    {
        return getStaff().values.map
        {
            entry -> Employee in
            return Employee(name: entry.getName(), title: entry.getJob())
        }
    }
}
 */
