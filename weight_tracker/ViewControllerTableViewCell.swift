//
//  ViewControllerTableViewCell.swift
//  weight_tracker
//
//  Created by Yash Patel on 29/10/16.
//  Copyright © 2016 Yash Patel. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var textweight: UILabel!
    @IBOutlet weak var textdate: UILabel!
    @IBOutlet weak var textemoji: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
