//
//  CommentTableViewCell.swift
//  swiftFinal
//
//  Created by cosine on 2015/12/23.
//  Copyright © 2015年 Lin Circle. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var com_user: UIButton!
    
    
    @IBOutlet weak var com_word: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
