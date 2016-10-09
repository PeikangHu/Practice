//
//  Proxy.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 10/8/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

protocol StockServer
{
    func getStockLevel(product:String, callback:(String, Int) -> Void)
    func setStockLevel(product:String, stockLevel:Int)
}

class StockServerFactory
{
    class func getStockServer() -> StockServer
    {
        return server
    }
    
    private class var server:StockServer
    {
        struct singletonWrapper
        {
            static let singleton:StockServer = StockServerProxy()
        }
        
        return singletonWrapper.singleton
    }
}

class StockServerProxy: StockServer
{
    func getStockLevel(product: String, callback: (String, Int) -> Void) {
        let stockConn = NetworkPool.getConnection()
        let level = stockConn.getStockLevel(name: product)
        
        if level != nil
        {
            callback(product, level!)
        }
        
        NetworkPool.returnConnection(conn: stockConn)
    }
    
    func setStockLevel(product: String, stockLevel: Int)
    {
        let stockConn = NetworkPool.getConnection()
        stockConn.setStockLevel(name: product, level: stockLevel)
        NetworkPool.returnConnection(conn: stockConn)
    }
}
