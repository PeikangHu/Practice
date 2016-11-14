//
//  SystemComponents.swift
//  Observer
//
//  Created by Peikang Hu on 10/12/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class ActivityLog:Observer
{
    func notify(notification:Notification)
    {
        print("Auth request for \(notification.type.rawValue). Success: \(notification.data!)")
    }
    
    func logActivity(activity:String)
    {
        print("Log: \(activity)")
    }
}

class FileCache:Observer
{
    func notify(notification:Notification)
    {
        if let authNotification = notification as? AuthenticationNotification
        {
            //if authNotification.requestSuccessed && authNotification.userName != loadFiles(user: authNotification.userName)
        }
        
        if notification.type == NotificationTypes.AUTH_SUCCESS
        {
            loadFiles(user: notification.data! as! String)
        }
    }
    
    func loadFiles(user:String)
    {
        print("Load files for \(user)")
    }
}

class AttackMonitor:Observer
{
    func notify(notification:Notification) {
        monitorSuspiciousActivity = (notification.type == NotificationTypes.AUTH_FAIL)
    }
    
    var monitorSuspiciousActivity:Bool = false
    {
        didSet
        {
            print("Monitoring for attack: \(monitorSuspiciousActivity)")
        }
    }
}

