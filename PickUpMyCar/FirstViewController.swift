//
//  FirstViewController.swift
//  PickUpMyCar
//
//  Created by Cristina Radulescu on 5/26/15.
//  Copyright (c) 2015 Cristina Radulescu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var logoutButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}

