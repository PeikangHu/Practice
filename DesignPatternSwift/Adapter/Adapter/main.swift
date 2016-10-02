//
//  main.swift
//  Adapter
//
//  Created by Peikang Hu on 10/1/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

/*
let search = SearchTool(dataSources: SalesDataSource(), DevelopmentDataSource())
*/

/*  Using extension
let search = SearchTool(dataSources: SalesDataSource(), DevelopmentDataSource(), NewCoDirectory())
*/

//  Using Wrapper Class
let search = SearchTool(dataSources: SalesDataSource(), DevelopmentDataSource(), NewCoDirectoryAdapter())

print("--List--")

for e in search.employees
{
    print("Name:\(e.name)")
}

print("--Search--")
for e in search.search(text: "VP", type: SearchTool.SearchType.TITLE)
{
    print("Name:\(e.name), Title: \(e.title)")
}
