//
//  ParkTableViewCell.swift
//  State Parks
//
//  Created by Watson Li on 9/30/17.
//  Copyright © 2017 Huaxin Li. All rights reserved.
//

import UIKit

class ParkTableViewCell: UITableViewCell {

    @IBOutlet var parkLabel : UILabel!
    @IBOutlet var parkImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
