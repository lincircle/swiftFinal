//
//  LikeTableViewCell.swift
//  swiftFinal
//
//  Created by cosine on 2015/12/23.
//  Copyright © 2015年 Lin Circle. All rights reserved.
//

import UIKit

class LikeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var like_people: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
