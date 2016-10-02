//: Playground - noun: a place where people can play

import Foundation

// Object reuse strategy: untrusting strategy
// @objc it can be implemented only by classes and not structs.
@objc protocol PoolItem
{
    var canReuse:Bool {get}
}

/*
    Run as a Queue
 */

// T:AnyObject means the Pool can work only with class-based objects.
class Pool<T:AnyObject>
{
    private var data = [T]()
    
    // Concurrency protection, only one block is executed at a time.
    private let arrayQ = DispatchQueue(label: "arrayQ")
    
    private let semaphore:DispatchSemaphore;
    
    // Lazy strategy - start
    //private var itemCount = 0
    //private let maxItemCount:Int
    private let itemFactory:() -> T
    
    /* Lazy strategy
    init(maxItemCount:Int, factory: @escaping () -> T)
    {
        self.itemFactory = factory
        self.maxItemCount = maxItemCount
        semaphore = DispatchSemaphore(value: maxItemCount)
    } */
    // Lazy strategy - end
    
    // Elastic pool (dealing with exhausted) - start
    private let peakFactory:() -> T
    private let peakReaper:(T) -> Void
    
    private var createdCount:Int = 0
    private let normalCount:Int
    private let peakCount:Int
    private let returnCount:Int
    private let waitTime:Int
    
    init(itemCount:Int, peakCount:Int, returnCount:Int, waitTime:Int = 2,
         itemFactory:@escaping ()->T, peakFactory:@escaping ()->T, reaper:@escaping (T)->Void)
    {
        self.normalCount = itemCount
        self.peakCount = peakCount
        
        self.waitTime = waitTime
        self.returnCount = returnCount
        
        self.itemFactory = itemFactory
        self.peakFactory = peakFactory
        
        self.peakReaper = reaper
        
        self.semaphore = DispatchSemaphore(value: itemCount)
    }
    
    
    // Pool Expiry strategy - start
    private var ejectedItems = 0
    private var poolExhausted = false
    // Pool Expiry strategy - end
    

    
    /* Eager strategy
    init(items:[T])
    {
        data.reserveCapacity(data.count)
        for item in items
        {
            data.append(item)
        }
        
        // the counter is decremented each time the wait function is called.
        semaphore = DispatchSemaphore(value: items.count)
    }*/
    
    // maxWaitSeconds: failing request strategy
    func getFromPool(maxWaitSeconds:Int = 5) -> T?
    {
        var result:T?
        
        // Elastic pool (Exhausted pool) - start
        let expiryTime = DispatchTime(uptimeNanoseconds:UInt64(maxWaitSeconds))
        
        if semaphore.wait(timeout: expiryTime) == .success
        {
            arrayQ.sync {
                if (self.data.count == 0)
                {
                    result = self.itemFactory()
                    self.createdCount += 1
                }
                else
                {
                    result = self.data.remove(at: 0)
                }
            }
        }
        else
        {
            arrayQ.sync {
                result = self.peakFactory()
                self.createdCount+=1
            }
        }
        // Elastic pool (Exhausted pool) - end
        
        /*
        // Failing request strategy
        let waitTime:DispatchTime = (maxWaitSeconds == -1)
        ? .distantFuture : DispatchTime(uptimeNanoseconds:UInt64(maxWaitSeconds))
        
        //dispatch_time(DISPATCH_TIME_NOW, (Int64(maxWaitSeconds) * Int64(NSEC_PER_SEC)));
        
        if (!poolExhausted)
        {
            if (semaphore.wait(timeout: waitTime) == .success)
            {
                if (!poolExhausted)
                {
                    arrayQ.sync
                    {
                        /* Eager strategy
                        result = self.data.remove(at: 0)
                        */
                        
                        // Lazy strategy - start
                        if (self.data.count == 0 && self.itemCount < self.maxItemCount)
                        {
                            result = self.itemFactory()
                            self.itemCount += 1
                        }
                        else
                        {
                            result = self.data.remove(at: 0)
                        }
                        // Lazy strategy - end
                    }
                }
            }
        }
         */
        return result;
    }
    
    func returnToPool(item:T)
    {
        arrayQ.async
        {
            /* trusting strategy
            self.data.append(item)
            self.semaphore.signal()
            */
            
            /* untrustring strategy
            let pitem = item as AnyObject as? PoolItem
            if (pitem == nil || pitem!.canReuse)
            {
                self.data.append(item)
                self.semaphore.signal()
            }
            */
            
            /* failing request strategy
            if let pitem = item as AnyObject as? PoolItem
            {
                if pitem.canReuse
                {
                    self.data.append(item)
                    self.semaphore.signal()
                }
                else
                {
                    self.ejectedItems += 1
                    if self.ejectedItems == self.maxItemCount
                    {
                        // Recognize when the pool is exhausted,
                        // I keep track of the number of objects that are rejected
                        self.poolExhausted = true
                        self.flushQueue()
                    }
                }
            }
            else
            {
                self.data.append(item)
            }*/
            
            // Elastic pool - start
            if (self.data.count > self.returnCount && self.createdCount > self.normalCount)
            {
                self.peakReaper(item)
                self.createdCount -= 1
            }
            else
            {
                self.data.append(item)
                self.semaphore.signal()
            }
        }
    }
    
    private func flushQueue()
    {
        let dQueue = DispatchQueue(label: "drainer", attributes: .concurrent)
        var backlogCleared = false
        
        dQueue.async {
            self.semaphore.wait(timeout: .distantFuture)
            backlogCleared = true
        }
        
        dQueue.async {
            while !backlogCleared
            {
                self.semaphore.signal()
            }
        }
    }
    
    // Lazy stategy - start
    func processPoolItems(callback:([T]) -> Void)
    {
        arrayQ.sync {
            callback(self.data)
        }
    }
    // Lazy strategy - end
}

class BookSeller
{
    class func buyBook(author:String, title:String, stockNumber:Int) -> Book
    {
        return Book(author: author, title: title, stock: stockNumber)
    }
}

class LibraryNetwork
{
    // additional Book objects will be obtained from the LibraryNetwork.borrowBook method,
    // and when the number of objects falls to 50% of the normal level, the additional objects are reaped by the LibraryNetwork.return book method.
    class func borrowBook(author:String, title:String, stockNumber:Int) -> Book
    {
        return Book(author: author, title:title, stock: stockNumber)
    }
    
    class func returnBook(book:Book)
    {
        // do nothing
    }
}

/*
    Lazy strategy:
        agreed to a line of credit with a bookseller that can be called upon as needed.
    
    The library holds no stock initially, but every time that there is a request for a book and there are no books in stock,
    the bookseller is asked to send a copy up until a predetermined limit - 200 copies in this case.
 
 */
final class Library
{
    // private var books:[Book] // Eager strategy
    private let pool:Pool<Book>;
    
    private init(stockLevel:Int)
    {
        /* Eager strategy
        books = [Book]()
        for count in 1 ... stockLevel
        {
            books.append(Book(author: "Dickens, Charles", title:"Hard Times", stock: count))
        }
        
        pool = Pool<Book>(items:books)
        */
        
        var stockId = 1
        
        /*
        pool = Pool<Book>(maxItemCount: stockLevel)
            {() in return BookSeller.buyBook(author: "Dickens, Charles", title: "Hard Times", stockNumber: stockId + 1)}
        */
        
        // Elastic pool: dealing with exhausted pools
        // When demand is twice the normal level, additional Book objects will be obtained from the 
        // LibraryNetwork.borrowBook method, and when the number of objects falls to 50% of the normal level,
        // the additional objects are reaped by the LibraryNetwork.return book method.
        pool = Pool<Book>(itemCount: stockLevel, peakCount: stockLevel * 2 ,
                          returnCount: stockLevel / 2, itemFactory:
                            {() in
                                return BookSeller.buyBook(author: "Dickens, Charles",
                                                          title: "Hard Times", stockNumber: stockId + 1)
                            }, peakFactory:
                            {() in
                                return LibraryNetwork.borrowBook(author: "Dickens, Charles", title: "Hard Times",
                                                                 stockNumber: stockId + 1)
                            }, reaper: LibraryNetwork.returnBook)
        stockId+=1
    }
    
    private class var singleton:Library
    {
        struct SingletonWrapper
        {
            static let singleton = Library(stockLevel:5)
        }
        
        return SingletonWrapper.singleton
    }
    
    class func checkoutBook(reader:String) -> Book?
    {
        let book = singleton.pool.getFromPool()
        book?.reader = reader
        book?.checkoutCount += 1
        return book;
    }
    
    class func returnBook(book:Book)
    {
        book.reader = nil
        singleton.pool.returnToPool(item: book)
    }
    
    class func printReport()
    {
        //for book in singleton.books // Eager strategy
        singleton.pool.processPoolItems(callback:
            {(books) in
                for book in books
                {
                    print("...Book#\(book.stockNumber)...")
                    print("Checked out \(book.checkoutCount) times")
                    
                    if (book.reader != nil)
                    {
                        print("Checked out to \(book.reader!)")
                    }
                    else
                    {
                        print("In stock")
                    }
                }
                print("There are \(books.count) books in the pool")
        })
    }
}


class Book: PoolItem
{
    let author:String
    let title:String
    let stockNumber:Int
    
    var reader:String?
    var checkoutCount = 0
    
    init(author:String, title:String, stock:Int)
    {
        self.author = author
        self.title = title
        self.stockNumber = stock
    }
    
    // untrusting strategy
    var canReuse: Bool
    {
        get
        {
            let reusable  = checkoutCount < 5
            if !reusable
            {
                print("Eject: Book#\(self.stockNumber)")
            }
            
            return reusable
        }
    }
}

var queue = DispatchQueue(label: "workQ", attributes: .concurrent)
var group = DispatchGroup()

print("Starting...")

for i in 1...35
{

    queue.async(group: group)
    {
        var book = Library.checkoutBook(reader: "reader#\(i)")
        if (book != nil)
        {
            Thread.sleep(forTimeInterval: Double(arc4random() % 2))
            Library.returnBook(book: book!)
        }
        else
        {
            // Failing request strategy
            queue.async {
                print("Request \(i) failed")
            }
        }
    }
}

group.wait(timeout: DispatchTime.distantFuture)

queue.sync {
    print("All blocks complete")
    Library.printReport()
}

