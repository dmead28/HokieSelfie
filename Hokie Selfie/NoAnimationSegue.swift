//
//  NoAnimationSegue.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 4/28/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class NoAnimationSegue: UIStoryboardSegue {
    override func perform() {
        //work in progress
        
        //println("NoAnimationSegue.perform() called")
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        /*
        
        let sourceView = self.sourceViewController.view!
        let destinationView = self.destinationViewController.view!
        
        let window = UIApplication.sharedApplication().keyWindow
        
        destinationView!.frame = CGRect(x: 0, y: 50, width: screenWidth, height: screenHeight)
        sourceView!.frame = CGRect(x: 0, y: 100, width: screenWidth, height: screenHeight)
        
        window!.insertSubview(destinationView!, aboveSubview: sourceView!)
        */
        
        let sourceView = self.sourceViewController.view!
        let destinationView = self.destinationViewController.view!
        let window = UIApplication.sharedApplication().keyWindow
        
        destinationView!.frame = CGRect(x: 0, y: 50, width: screenWidth, height: screenHeight)
        
        window!.insertSubview(destinationView!, aboveSubview: sourceView!)
        self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
    }
}
