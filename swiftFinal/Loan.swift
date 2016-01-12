//
//  Loan.swift
//  swiftFinal
//
//  Created by cosine on 2016/1/12.
//  Copyright © 2016年 Lin Circle. All rights reserved.
//

import Foundation

class Loan {
    
    var user_name:String = ""
    
    var user_profile_picture:String = ""
    
    var image:String = ""
    
    var like:Int = 0
    
    var comment:String = ""
    
    func description() {
    
        print("user_name: \(self.user_name)")
        
        print("user_profile_picture: \(self.user_profile_picture)")
        
        print("image: \(self.image)")
        
        print("like: \(self.like)")
        
        print("comment: \(self.comment)")
        
    }
    
}