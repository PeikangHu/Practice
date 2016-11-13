//
//  Views.swift
//  MVC
//
//  Created by Peikang Hu on 10/16/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol View
{
    func execute()
}

class PersonListView:View
{
    private let people:[Person]
    
    init(data:[Person]) {
        self.people = data
    }
    
    func execute() {
        for person in people
        {
            print(person)
        }
    }
}

class CityListView: View
{
    private let cities:[String]
    
    init(data:[String])
    {
        self.cities = data
    }
    
    func execute()
    {
        for city in self.cities
        {
            print("City: \(city)")
        }
    }
}
