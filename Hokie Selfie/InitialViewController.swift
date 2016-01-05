//
//  InitialViewController.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 4/19/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        //return to the sign in screen if the user hasn't signed in yet to force/remind them to use facebook
        //TODO: decide if ^ is ethically right and user friendly
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            //println("signed in")
            performSegueWithIdentifier("initialToCamera", sender: self)
        } else {
            //println("not signed in")
            performSegueWithIdentifier("initialToSignIn", sender: self)
        }
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
    
    //MARK: Onboarding handling
    static var goToOnboard: Bool = true
    static let BUILD_NUM: Int = 1 //onboard build num. not to be confused with app build num
    static func shouldGoToOnbooard() -> Bool {
        //for simulting first launch (to see the onboarding process)
        //return true
        
        let buildNum: Int? = NSUserDefaults.standardUserDefaults().valueForKey("buildNum") as? Int
        //println(buildNum)
        if buildNum != nil {
            return !(buildNum! == BUILD_NUM)
        } else {
            return true
        }
    }

}
