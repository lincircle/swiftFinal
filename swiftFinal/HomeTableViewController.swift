//
//  HomeTableViewController.swift
//  swiftFinal
//
//  Created by cosine on 2015/12/23.
//  Copyright © 2015年 Lin Circle. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let data = [
        [
            [
                "userid":"Amy"
            ],
            [
                "userimg":"img01.png"
            ],
            [
                "":""
            ],
            [
                "likename":"zoo,fywi,hhei"
            ],
            [
                "fanid":"eee",
                "fanword":"eqoqwoi"
            ],
            [
                "fanid":"wyqy",
                "fanword":"wuququ"
            ]
        
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.data.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data[section].count
    }

    /*override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
    }*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if(indexPath.row == 0){
        
            let user_cell = tableView.dequeueReusableCellWithIdentifier("usercell", forIndexPath: indexPath) as! UserTableViewCell
          
            user_cell.userId.text = data[indexPath.section][indexPath.row]["userid"]
            
            cell = user_cell
        }
        if(indexPath.row == 1){
            
            let img_cell = tableView.dequeueReusableCellWithIdentifier("imgcell", forIndexPath: indexPath) as! ImgTableViewCell
            
            img_cell.sharePic.image = UIImage(named: data[indexPath.section][indexPath.row]["userimg"]!)
            
            cell = img_cell
            
        }
        if(indexPath.row == 2){
            
            let btn_cell = tableView.dequeueReusableCellWithIdentifier("btncell", forIndexPath: indexPath) as! BtnTableViewCell
            
            btn_cell.btn_like.setTitle("like", forState: .Normal)
            btn_cell.btn_comment.setTitle("comment", forState: .Normal)
            
            
            cell = btn_cell
        }
        if(indexPath.row == 3){
            
            let like_cell = tableView.dequeueReusableCellWithIdentifier("likecell", forIndexPath: indexPath) as! LikeTableViewCell
            
            like_cell.like_people.text = data[indexPath.section][indexPath.row]["likename"]
            
            cell = like_cell
        }
        if(4 <= indexPath.row){
            
            let comment_cell = tableView.dequeueReusableCellWithIdentifier("commentcell", forIndexPath: indexPath) as! CommentTableViewCell
            
            comment_cell.com_user.setTitle(data[indexPath.section][indexPath.row]["fanid"], forState: .Normal)
            comment_cell.com_word.text = data[indexPath.section][indexPath.row]["fanword"]
            
            
            cell = comment_cell
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
