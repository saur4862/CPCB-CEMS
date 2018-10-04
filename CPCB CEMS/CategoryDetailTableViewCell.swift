//
//  CategoryDetailTableViewCell.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 02/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class CategoryDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var param: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
