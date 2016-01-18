//
//  HomeTableViewController.swift
//  swiftFinal
//
//  Created by cosine on 2015/12/23.
//  Copyright © 2015年 Lin Circle. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let data: [[String: AnyObject]] = [
        [
            "type": "post",
            "id": 123,
            "content": [
                "userid":"Amy",
                "userimg":"img01.png",
                "likename":"zoo,fywi,hhei",
                "comment": [
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
        ],
        [
            "type": "ad"
        ],
        [
            "type": "post",
            "id": 123,
            "content": [
                "userid":"Amy",
                "userimg":"img01.png",
                "likename":"zoo,fywi,hhei",
                "comment": [
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
        ]
    ]
    
    let  url_to_request = "https://api.instagram.com/v1/media/popular?client_id=642176ece1e7445e99244cec26f4de1f";
    
    var loans = [Loan]()
    
    func dataRequest(){
        
        let request = NSURLRequest(URL: NSURL(string: url_to_request)!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(
            request,
            completionHandler: { (data, response, error) -> Void in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                
                self.parseJsonData(data!)
                
                
                self.tableView.reloadData() //資料一開始載入只在記憶體，需要此動作才可以

            }
        )
        
        task.resume()
    }
    
    func parseJsonData(data:NSData) {
        
        var jsonResult:[String:AnyObject]!
        
        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
            //print(jsonResult)
        }
        catch {
            print("json:error\(error)")
        }
        
        let jsonLoans = jsonResult["data"] as! [AnyObject]
        for jsonLoan in jsonLoans{
            
            let loan = Loan()
            
            let user = jsonLoan["user"] as! [String:AnyObject]
            loan.user_name = user["username"] as! String
            loan.user_profile_picture = user["profile_picture"] as! String
            
            let images = jsonLoan["images"] as! [String:[String: AnyObject]]
            loan.image = images["standard_resolution"]!["url"] as! String
            
            if let like = jsonLoan["likes"] as? [String:AnyObject] {
            
                loan.like = like["count"] as! Int
            
            }
            
            let comments = jsonLoan["comments"] as! [String:AnyObject]
            let commentsdata = comments["data"] as! [[String:AnyObject]]
            
            for commentdata in commentsdata{
                
                let comment = Comment()
                
                comment.text = commentdata["text"] as! String
                
                let from = commentdata["from"] as! [String:AnyObject]
                comment.people = from["username"] as! String
                
                loan.comments.append(comment)
                
            }
            
            
            self.loans.append(loan)
        
        }
        
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataRequest()

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
        return self.loans.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 4 + loans[section].comments.count
        
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.row {
        
        case 1:
            
            return 200.0
            
        default:
            
            return 70.0
        }
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        var cell = UITableViewCell()
    
            
        let content = self.loans[indexPath.section]
            
        switch indexPath.row {
        
        case 0:
        
            let user_cell = tableView.dequeueReusableCellWithIdentifier("usercell", forIndexPath: indexPath) as! UserTableViewCell
          
            user_cell.userId.text = content.user_name
            
            
            cell = user_cell
        
        
        case 1:
            
            let img_cell = tableView.dequeueReusableCellWithIdentifier("imgcell", forIndexPath: indexPath) as! ImgTableViewCell
            
            img_cell.sharePic.image = UIImage(data: NSData(contentsOfURL: NSURL(string: content.image)!)!)
            
            //img_cell.sharePic.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "https://scontent.cdninstagram.com/hphotos-xpa1/t51.2885-15/s640x640/sh0.08/e35/12501935_1560383174253179_1940524105_n.jpg")!)!)
            
            
            cell = img_cell
            
        
        case 2:
            
            let btn_cell = tableView.dequeueReusableCellWithIdentifier("btncell", forIndexPath: indexPath) as! BtnTableViewCell
            
            btn_cell.btn_like.setTitle("like", forState: .Normal)
            btn_cell.btn_comment.setTitle("comment", forState: .Normal)
            
            btn_cell.btn_comment.addTarget(self, action: Selector("goComment:"), forControlEvents: .TouchUpInside)
            
            //btn_cell.btn_comment.tag = data[indexPath.section]["id"] as! Int
            
            cell = btn_cell
        
            
        case 3:
            
            let like_cell = tableView.dequeueReusableCellWithIdentifier("likecell", forIndexPath: indexPath) as! LikeTableViewCell
            
            like_cell.like_people.text = String(content.like)
            
            cell = like_cell
        
            
        default:
            
            
            let comment_cell = tableView.dequeueReusableCellWithIdentifier("commentcell", forIndexPath: indexPath) as! CommentTableViewCell
            
            let index = indexPath.row - 4
            
            comment_cell.com_user.setTitle(content.comments[index].people, forState: .Normal)
            comment_cell.com_word.text = content.comments[index].text
            
            
            cell = comment_cell
        
        
        }
        

        return cell
    }
    
    
    func goComment(trigger: UIButton){
        
        performSegueWithIdentifier("goComment", sender: trigger.tag)
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let ROUTE = segue.identifier ?? ""
        
        switch ROUTE {
            
            
        case "goComment":
            
            let vc = segue.destinationViewController as! CommentViewController
            vc.id = sender as! Int
            
            
        default:
            
            break
            
        }
        
        
        
        
    }
    

}
