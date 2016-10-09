//
//  ProductDecorators.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 10/5/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class PriceDecorator: Product
{
    fileprivate let wrappedProduct:Product
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        fatalError("Not supported")
    }
    
    init(product:Product)
    {
        self.wrappedProduct = product
        
        super.init(name: product.name, description: product.productDescription, category: product.category, price: product.price, stockLevel: product.stockLevel)
    }
}

class LowStockIncreaseDecorator: PriceDecorator
{
    override var price: Double
    {
        var price = wrappedProduct.price
        
        if (stockLevel <= 4)
        {
            price = price * 1.5
        }
        
        return price
    }
}

class SoccerDecreaseDecorator: PriceDecorator
{
    override var price:Double
    {
        return super.wrappedProduct.price * 0.5
    }
}
