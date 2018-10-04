//
//  DetailTableViewCell.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var livePoint: UILabel!
    
    @IBOutlet weak var indusPoint: UILabel!
    @IBOutlet weak var liveView: UIView!
    @IBOutlet weak var indusView: UIView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorderWidth(0.5,UIColor.black)
        mainView.layer.cornerRadius = 5
        liveView.layer.cornerRadius = 10
        indusView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
