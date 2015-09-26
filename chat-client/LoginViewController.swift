//
//  LoginViewController.swift
//  chat-client
//
//  Created by John Franklin on 9/24/15.
//  Copyright © 2015 JF. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: ViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func onSignIn(sender: UIButton) {
        print("Sign In happened")
        PFUser.logInWithUsernameInBackground(usernameText.text!, password:passwordText.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                print("login success")
                self.performSegueWithIdentifier("chatSegue", sender: self)
            } else {
                print ("login failed")
                // The login failed. Check error to see why.
            }
        }
    }
    
    @IBAction func onSignUp(sender: UIButton) {
        print("Sign Up happened")
        let user = PFUser()
        user.username = usernameText.text
        user.password = passwordText.text
        user.email = "john@walmartlabs.com"
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                _ = error.userInfo["error"] as? NSString
                
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameText.text = "johnf"
        passwordText.text = "password"

        // Do any additional setup after loading the view.
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
