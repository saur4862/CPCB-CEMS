//
//  CategoryTableViewCell.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 02/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var limitView: UIView!
    @IBOutlet weak var lowerLabel: UILabel!
    @IBOutlet weak var upperLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        limitView.addBorderWidth(2.0, UIColor.black)
        limitView.layer.cornerRadius = 20
        // Initialization code
    }
    
    
    func updateCell(_ data:Category){
        upperLabel.text = data.type
        lowerLabel.text = data.desc
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
