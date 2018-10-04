//
//  NavigationView.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class NavigationView: UIView {

    @IBOutlet weak var backWidth: NSLayoutConstraint!
    @IBOutlet weak var navImage: UIImageView!
    @IBOutlet weak var heading: UILabel!
    
    var goBacks:(() -> Void)!
    
    @IBAction func goBack(_ sender: Any) {
        if goBacks != nil{
            goBacks?()
        }
    }
}
