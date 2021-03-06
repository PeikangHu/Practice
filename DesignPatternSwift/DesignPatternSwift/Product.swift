//
//  Product.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 9/15/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class Product: NSObject, NSCopying
{
    // Read only
    private(set) var name:String
    // Change description to productDescription because the NSObject class defines a method called description.
    private(set) var productDescription:String
    private(set) var category:String
    
    private var stockLevelBackingValue:Int = 0
    private var priceBackingValue:Double = 0
    
    fileprivate var salesTaxRate:Double  = 0.2
    
    required init(name:String, description:String, category:String, price:Double, stockLevel:Int)
    {
        self.name = name
        self.productDescription = description
        self.category = category
        
        // Initializers of subclasses invoke the initializer of their superclass,
        // but this must be done after the stored properties have been set and 
        //                       before the computed properties are used.
        super.init()
        
        self.price = price
        self.stockLevel = stockLevel
        
    }
    
    var stockLevel:Int
    {
        get { return stockLevelBackingValue }
        set {
                stockLevelBackingValue = max(0, newValue)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "stockUpdate"), object: self)
            }
    }
    
    
    fileprivate(set) var price:Double
    {
        get { return priceBackingValue }
        set { priceBackingValue = max(1, newValue) }
    }
    
    var stockValue:Double
    {
        //get { return (price * (1 + salesTaxRate)) * Double(stockLevel) }
        get { return price * Double(stockLevel) }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: self.name, description: self.description,
                       category:self.category, price:self.price,
                       stockLevel: self.stockLevel)
    }
    
    /*
    var upsells:[UpsellOpportunities]
    {
        get { return Array() }
    }*/
    
    class func createProduct(name:String, description:String, category:String, price:Double, stockLevel:Int) -> Product
    {
        return Product(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
    }
    
    /*
    class func createProduct(name:String, description:String, category:String, price:Double, stockLevel:Int) -> Product
    {
        var productType:Product.Type
        
        switch(category)
        {
            case "Watersports": productType = WatersportsProduct.self
            case "Soccer": productType = SoccerProduct.self
            default: productType = Product.self
        }
        
        return productType.init(name: name, description: description, category: category, price:price, stockLevel:stockLevel)
    }*/
}

// Start: Composite Class
class ProductComposite:Product
{
    private let products:[Product]
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        fatalError("Not implemented")
    }
    
    init(name: String, description: String, category: String, stockLevel: Int, products:Product...) {
        self.products = products
        super.init(name: name, description: description, category: category, price: 0, stockLevel: stockLevel)
    }
    
    override var price:Double
    {
        get { return products.reduce(0, {(total, p) in return total + p.price}) }
        set { /* do nothing */ }
    }
}

/*
enum UpsellOpportunities
{
    case SwimmingLessons
    case MapOfLakes
    case SoccerVideos
}

class WatersportsProduct: Product
{
    required init(name:String, description: String, category:String, price:Double, stockLevel:Int)
    {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        
        salesTaxRate = 0.1
    }
    
    override var upsells: [UpsellOpportunities]
    {
        return [UpsellOpportunities.SwimmingLessons, UpsellOpportunities.MapOfLakes]
    }
}

class SoccerProduct:Product
{
    required init(name:String, description:String, category:String, price:Double, stockLevel:Int)
    {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        
        salesTaxRate = 0.25
    }
    
    override var upsells: [UpsellOpportunities]
    {
        return [UpsellOpportunities.SoccerVideos]
    }
}
 */


