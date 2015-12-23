//
//  UserTableViewCell.swift
//  swiftFinal
//
//  Created by cosine on 2015/12/23.
//  Copyright © 2015年 Lin Circle. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPic: UIImageView!
    
    @IBOutlet weak var userId: UILabel!
    
    @IBOutlet weak var offset: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
