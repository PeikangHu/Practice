//: Playground - noun: a place where people can play

import Foundation



final class Logger
{
    private var data = [String]()
    
    fileprivate init()
    {
        // do nothing - required to stop instances being created by code in other files
    }
    
    func log(msg:String)
    {
        data.append(msg)
    }
    
    func printLog()
    {
        for msg in data
        {
            print("Log: \(msg)")
        }
    }
}

let productLogger = Logger<Product>(callback: {p in
    println("Change: \(p.name) \(p.stockLevel) items in stock");
});


class Logger<T where T:NSObject, T:NSCopying> {
    var dataItems:[T] = [];
    var callback:(T) -> Void;
    var arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_CONCURRENT);
    var callbackQ = dispatch_queue_create("callbackQ", DISPATCH_QUEUE_SERIAL);
    
    init(callback:T -> Void, protect:Bool = true) {
        self.callback = callback;
        if (protect) {
            self.callback = {(item:T) in
                dispatch_sync(self.callbackQ, {() in
                    callback(item);
                });
            };
        }
    }
    
    func logItem(item:T) {
        dispatch_barrier_async(arrayQ, {() in
            self.dataItems.append(item.copy() as T);
            self.callback(item);
        });
    }
    
    func processItems(callback:T -> Void) {
        dispatch_sync(arrayQ, {() in
            for item in self.dataItems {
                callback(item);
            }
        });
    }
}

// The usage of Singleton
 productLogger.logItem(product);


let globalLogger = Logger()

class DataItem
{
    enum ItemType: String
    {
        case Email = "Email Address"
        case Phone = "Telephone Number"
        case Card = "Credit Card Number"
    }
    
    var type:ItemType
    var data:String
    
    init(type:ItemType, data: String)
    {
        self.type = type
        self.data = data
    }
}

final class BackupServer
{
    let name:String
    
    private var data = [DataItem]()
    
    private init(name:String)
    {
        self.name = name
        globalLogger.log(msg: "Created new server \(name)")
    }
    
    func backup(item:DataItem)
    {
        data.append(item)
        globalLogger.log(msg: "\(name) backed up item of type \(item.type.rawValue)")
    }
    
    func getData() -> [DataItem]
    {
        return data
    }
    
    class var server:BackupServer
    {
        struct SingletonWrapper
        {
            static let singleton = BackupServer(name: "MainServer")
        }
        
        return SingletonWrapper.singleton
    }
}

var server = BackupServer.server


server.backup(item: DataItem(type: DataItem.ItemType.Email, data: "joe@example.com"))

