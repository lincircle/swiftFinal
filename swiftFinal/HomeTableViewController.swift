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
                
                let json_objs = self.parseJsonData(data!)

                for obj in json_objs {
                
                    obj.description()
                    
                }
                
            }
        )
        
        task.resume()
    }
    
    func parseJsonData(data:NSData) ->[Loan] {
        
        var loans = [Loan]()
        
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
            
            if let comment = jsonLoan["comments"] as? [String:AnyObject] {
            
                //loan.comment = comment["data"] as! String
            
            }
            
            loans.append(loan)
        }
        
        return loans
        
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
        return self.data.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (data[section]["type"] as? String) == "ad" {
            
            return 1
            
        }
        
        let content = self.data[section]["content"] as! [String: AnyObject]
        let comment = content["comment"] as! [[String: String]]
        return 4 + comment.count
        
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
        
        if (data[indexPath.section]["type"] as? String) == "ad" {
        
            cell.textLabel?.text = "廣告"
            
            return cell
            
        }
        else {
            
            let content = self.data[indexPath.section]["content"] as! [String: AnyObject]
        switch indexPath.row {
        
        case 0:
        
            let user_cell = tableView.dequeueReusableCellWithIdentifier("usercell", forIndexPath: indexPath) as! UserTableViewCell
          
            user_cell.userId.text = content["userid"] as? String
            
            cell = user_cell
        
        
        case 1:
            
            let img_cell = tableView.dequeueReusableCellWithIdentifier("imgcell", forIndexPath: indexPath) as! ImgTableViewCell
            
            img_cell.sharePic.image = UIImage(named: content["userimg"] as! String)
            
            cell = img_cell
            
        
        case 2:
            
            let btn_cell = tableView.dequeueReusableCellWithIdentifier("btncell", forIndexPath: indexPath) as! BtnTableViewCell
            
            btn_cell.btn_like.setTitle("like", forState: .Normal)
            btn_cell.btn_comment.setTitle("comment", forState: .Normal)
            
            btn_cell.btn_comment.addTarget(self, action: Selector("goComment:"), forControlEvents: .TouchUpInside)
            
            btn_cell.btn_comment.tag = data[indexPath.section]["id"] as! Int
            
            cell = btn_cell
        
            
        case 3:
            
            let like_cell = tableView.dequeueReusableCellWithIdentifier("likecell", forIndexPath: indexPath) as! LikeTableViewCell
            
            like_cell.like_people.text = content["likename"] as? String
            
            cell = like_cell
        
            
        default:
            
            let comment = content["comment"] as! [[String: String]]
            
            let comment_cell = tableView.dequeueReusableCellWithIdentifier("commentcell", forIndexPath: indexPath) as! CommentTableViewCell
            
            let index = indexPath.row - 4
            
            comment_cell.com_user.setTitle(comment[index]["fanid"], forState: .Normal)
            comment_cell.com_word.text = comment[index]["fanword"]
            
            
            cell = comment_cell
        
        
        }
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
