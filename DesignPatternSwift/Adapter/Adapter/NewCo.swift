//
//  NewCo.swift
//  Adapter
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class NewCoStaffMember
{
    private var name:String
    private var role:String
    
    init(name:String, role:String)
    {
        self.name = name
        self.role = role
    }
    
    func getName() -> String
    {
        return name
    }
    
    func getJob() -> String
    {
        return role
    }
}

/*
    We may not change the code for this class.
 
 */
class NewCoDirectory
{
    private var staff:[String: NewCoStaffMember]
    
    init()
    {
        staff = ["Hans": NewCoStaffMember(name: "Hans", role:"Corp Counsel"),
                 "Greta":NewCoStaffMember(name:"Greta", role:"VP, Legal")]
    }
    
    func getStaff() -> [String:NewCoStaffMember]
    {
        return staff
    }
    
}
