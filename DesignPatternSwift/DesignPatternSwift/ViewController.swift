//
//  ViewController.swift
//  DesignPatternSwift
//
//  Created by Peikang Hu on 9/11/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import UIKit

class ProductTableCell: UITableViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    var product:Product?;
}

var handler =
    {
        (p:Product) in
            print("Change: \(p.name) \(p.stockLevel) items in stock")
    }

class ViewController: UIViewController, UITableViewDataSource
{
    var productStore = ProductDataStore()
    
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let logger = productlogger //Logger<Product>(callback: handler)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayStockTotal()
        
        // This is the bridge pattern
        let bridge = EventBridge(callback: updateStockLevel)
        
        productStore.callback = bridge.inputCallback
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake
        {
            print("Shake motion detected")
            undoManager?.undo()
        }
    }
    
    func updateStockLevel(name:String, level:Int)
    {
        for cell in self.tableView.visibleCells
        {
            if let pcell = cell as? ProductTableCell
            {
                if pcell.product?.name == name
                {
                    pcell.stockStepper.value = Double(level)
                    pcell.stockField.text = String(level)
                }
            }
        }
        
        self.displayStockTotal()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = productStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableCell
        
        cell.product = product
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        
        CellFormatter.createChain().formatCell(cell: cell)
        
        return cell
        
    }
    
    @IBAction func stockLevelDidChange(_ sender: AnyObject)
    {
        if var currentCell = sender as? UIView
        {
            while(true)
            {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell
                {
                    if let product = cell.product
                    {
                        let dict = NSDictionary(objects: [product.stockLevel], forKeys:[product.name as NSCopying])
                        
                        undoManager?.registerUndo(withTarget: self, selector: Selector(("undoStockLevel:")), object: dict)
                        
                        
                        if let stepper = sender as? UIStepper
                        {
                            product.stockLevel = Int(stepper.value)
                        }
                        else if let textfield = sender as? UITextField
                        {
                            if let newValue =  Int(textfield.text!)
                            {
                                product.stockLevel = newValue;
                            }
                        }
                        
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text  = String(product.stockLevel)
                        logger.logItem(item: product)
                        
                        StockServerFactory.getStockServer().setStockLevel(product: product.name, stockLevel: product.stockLevel)
                    }
                    
                    break
                }
            }
            
            displayStockTotal()
        }
    }
    
    func undoStockLevel(data:[String:Int])
    {
        let productName = data.keys.first
        
        if productName != nil
        {
            let stockLevel = data[productName!]
            
            if stockLevel != nil
            {
                for nproduct in productStore.products
                {
                    if nproduct.name == productName!
                    {
                        nproduct.stockLevel = stockLevel!
                    }
                }
                
                updateStockLevel(name: productName!, level: stockLevel!)
            }
        }
        
    }
    
    func displayStockTotal()
    {
        let finalTotals:(Int, Double) = productStore.products.reduce((0, 0.0),
                                                        {(totals, product) -> (Int, Double) in
                                                            return (
                                                                totals.0 + product.stockLevel,
                                                                totals.1 + product.stockValue)
                                                        })
        
        let formatted = StockTotalFacade.formatCurrencyAmount(amount: finalTotals.1,
                                                              currency: StockTotalFacade.Currency.EUR)
        
        /* This code turns into facade
        let factory = StockTotalFactory.getFactory(curr: StockTotalFactory.Currency.EUR)
        let totalAmount = factory.converter?.convertTotal(total: finalTotals.1)
        let formatted = factory.formatter?.formatTotal(total: totalAmount!)
        */
        
        
        
        //totalStockLabel.text = "\(finalTotals.0) Products in Stock. " + "Total Value: \(Utils.currencyStringFromNumber(number: finalTotals.1))"
        
        totalStockLabel.text = "\(finalTotals.0) Products in Stock. " + "Total Value: \(formatted!)"
    }
}

