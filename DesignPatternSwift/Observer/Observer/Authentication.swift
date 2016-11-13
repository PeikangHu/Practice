//
//  Authentication.swift
//  Observer
//
//  Created by Peikang Hu on 10/12/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class AuthenticationManager: SubjectBase
{
    private let log = ActivityLog()
    private let cache = FileCache()
    private let monitor = AttackMonitor()
    
    func authenticate(user:String, pass:String) -> Bool
    {
        var nType = NotificationTypes.AUTH_FAIL
        //var result = false
        
        if user == "bob" && pass == "secret"
        {
            //result = true
            nType = NotificationTypes.AUTH_SUCCESS
            print("User \(user) is authenticated")
            
            /*
            // call system components
            log.logActivity(activity: "Authenticated \(user)")
            cache.loadFiles(user: user)
            monitor.monitorSuspiciousActivity = false
             */
        }
        else
        {
            print("Failed authentication attempt")
            /*
            // call system components
            log.logActivity(activity: "Failed authentication: \(user)")
            monitor.monitorSuspiciousActivity = true
            */
        }
        
        sendNotification(notification: Notification(type: nType, data: user))
        
        return nType == NotificationTypes.AUTH_SUCCESS
        //return result
    }
}
