//
//  LandingViewController.swift
//  PickUpMyCar
//
//  Created by Cristina Radulescu on 5/26/15.
//  Copyright (c) 2015 Cristina Radulescu. All rights reserved.
//

import Foundation
import UIKit

class LandingViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var facebookLogin: NSLayoutConstraint!
    @IBOutlet var facebookLoginButton: FBSDKLoginButton!
    private var initialViewController: UIViewController?
    
    @IBAction func didTapLoginButton(sender: FBSDKLoginButton)
    {
        //FBSDKLoginManager().logInWithReadPermissions(["public_profile", "email", "user_friends"], handler: handleFacebookLoginResponse)
        //facebookLoginButton.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            self.goToHomeScreen()
        }
        facebookLoginButton.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if ((error) != nil)
        {
            // Process error
            self.handleFacebookLoginError(error)
        }
        else if result.isCancelled
        {
            // Handle cancellations
            self.handleFacebookLoginCancellation(result)
            
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                
            }
            
            self.goToHomeScreen()
        }
    }
    
    func goToHomeScreen()
    {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        initialViewController = storyboard.instantiateInitialViewController() as? UIViewController
        self.presentViewController(initialViewController!, animated:true, completion:nil)
    }
    
    
    func handleFacebookLoginError(error: NSError!)
    {
        self.prepareForRetry()
    }
    
    func handleFacebookLoginCancellation(result: FBSDKLoginManagerLoginResult!)
    {
        self.prepareForRetry()
    }
    
    func prepareForRetry()
    {
        facebookLoginButton.hidden = false
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton)
    {
        println("User Logged Out \n")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
    
}

