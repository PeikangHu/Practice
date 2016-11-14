//
//  ProtocolStrategy.swift
//  Strategy
//
//  Created by Peikang Hu on 10/15/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class DataSourceStrtegy: NSObject, UITableViewDataSource
{
    let data:[Printable]
    
    init(_data:Printable...)
    {
        slef.data = data
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return data.count
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel.text = data[indexPath.row].description
        return cell
    }
}

let dataSource = DataSourceStrategy("London", "New York", "Paris", "Rome")
let table = UITableView(frame: CGREectMake(0,0,400,200))
table.dataSource = dataSource
table.reloadData()

// required for display in assistant editor
table
