//
//  PieModal.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class PieModel:NSObject{
    var count = 0
    var id = 0
    var category = ""
    var categoryType = ""
    
    func upateModal(_ dict:[String:Any]){
        if let int = dict["count"] as? Int{
            count = int
        }
        if let int = dict["id"] as? Int{
            id = int
        }
        if let str = dict["category"] as? String{
            category = str
            categoryType = "category"
        }
        if let str = dict["state"] as? String{
            category = str
            categoryType = "state"
        }
        if let str = dict["effluent"] as? String{
            category = str
            categoryType = "effluent"
        }
        if let str = dict["emission"] as? String{
            category = str
            categoryType = "emission"
        }
    }
}

class BarModel:NSObject{
    var offline = 0
    var delayed = 0
    var id = 0
    var category = ""
    var live = 0
    
    func upateModal(_ dict:[String:Any]){
        if let int = dict["offline"] as? Int{
            offline = int
        }
        if let int = dict["live"] as? Int{
            live = int
        }
        if let int = dict["delayed"] as? Int{
            delayed = int
        }
        if let int = dict["id"] as? Int{
            id = int
        }
        if let str = dict["category"] as? String{
            category = str
        }
    }
}

class Category:NSObject{
    var id = 0
    var type = ""
    var desc = ""
    var status = ""
    
    func updateModal(_ dict:[String:Any]){
        if let int = dict["id"] as? Int{
            id = int
        }
        if let str = dict["type"] as? String{
            type = str
        }
        if let str = dict["description"] as? String{
            desc = str
        }
        if let str = dict["status"] as? String{
            status = str
        }
    }
}

class CategoryDetails:NSObject{
    
    var unit = ""
    var min = 0
    var param = ""
    var max = 0
    var category = ""
    
    func updateModal(_ dict:[String:Any]){
        if let int = dict["min"] as? Int{
            min = int
        }
        if let int = dict["max"] as? Int{
            max = int
        }
        if let str = dict["unit"] as? String{
            unit = str
        }
        if let str = dict["param"] as? String{
            param = str
        }
        if let str = dict["category"] as? String{
            category = str
        }
    }
}
