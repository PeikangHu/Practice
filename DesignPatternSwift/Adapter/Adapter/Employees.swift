//
//  Employees.swift
//  Adapter
//
//  Created by Peikang Hu on 10/1/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

struct Employee
{
    var name:String
    var title:String
}

/*
    The problems start when a new source of data needs to be integrated into the directory that does not conform to the protocol.
 */
protocol EmployeeDataSource
{
    var employees:[Employee] { get }
    func searchByName(name:String) -> [Employee]
    func searchByTitle(title:String) -> [Employee]
}

