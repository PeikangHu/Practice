//
//  Observer.swift
//  Observer
//
//  Created by Peikang Hu on 10/12/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

enum NotificationTypes: String
{
    case AUTH_SUCCESS = "AUTH_SUCCESS"
    case AUTH_FAIL = "AUTH_FAIL"
}

class Notification
{
    let type:NotificationTypes
    let data:Any?
    
    init(type:NotificationTypes, data:Any?)
    {
        self.type = type
        self.data = data
    }
}

class AuthenticationNotification:Notification
{
    init(user:String, success:Bool)
    {
        super.init(type:success ? NotificationTypes.AUTH_SUCCESS : NotificationTypes.AUTH_FAIL, data:user)
    }
    
    var userName: String?
    {
        return self.data as! String?
    }
    
    var requestSuccessed:Bool
    {
        return self.type == NotificationTypes.AUTH_SUCCESS
    }
}

protocol Observer: class
{
    func notify(notification:Notification)
}

private class WeakObserverReference
{
    weak var observer:Observer?
    
    init(observer:Observer)
    {
        self.observer = observer
    }
}

protocol Subject
{
    func addObservers(observers:Observer...)
    func removeObserver(observer:Observer)
}

class SubjectBase: Subject
{
    private var observers = [WeakObserverReference]()
    private var collectionQueue = DispatchQueue(label: "colQ", attributes:.concurrent)
    
    func addObservers(observers: Observer...) {
        self.collectionQueue.sync(flags: .barrier)
        {
            for newOb in observers
            {
                self.observers.append(WeakObserverReference(observer: newOb))
            }
        }
    }
    
    func removeObserver(observer: Observer) {
        self.collectionQueue.sync(flags: .barrier)
        {
            self.observers = self.observers.filter()
                { weakref in
                    return weakref.observer != nil && weakref.observer !== observer
                }
        }
    }
    
    func sendNotification(notification:Notification)
    {
        self.collectionQueue.sync {
            for ob in self.observers
            {
                ob.observer?.notify(notification: notification)
            }
        }
    }
}
