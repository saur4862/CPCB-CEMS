//
//  ExceeDetailsTableViewCell.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 02/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ExceeDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorderWidth(0.5, UIColor.gray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
