//
//  ChatViewController.swift
//  chat-client
//
//  Created by John Franklin on 9/24/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatText: UITextField!

    var result : [PFObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        onTimer()
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }
    

    func onTimer() {
        print("Refresh called.")
        let query = PFQuery(className:"Message").includeKey("user").orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (messages:[PFObject]?, error:NSError?) -> Void in
            self.result = messages
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if result != nil {
            return (result?.count)!
        } else {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageTableViewCell", forIndexPath: indexPath) as! MessageTableViewCell
        if (result?.count > 0) {
            cell.textField.text = result![indexPath.row]["text"] as? String
        }
        return cell;
    }

    @IBAction func onSend(sender: UIButton) {
        let message = PFObject(className:"Message")
        message["text"] = self.chatText.text
        
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("object saved")
            } else {
                // There was a problem, check error.description
                print(error!.description)
            }
        }
    }
    
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
