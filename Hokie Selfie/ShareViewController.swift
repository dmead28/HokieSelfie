//
//  ShareViewController.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 4/28/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    @IBOutlet weak var loadingView: UIView!
    
    var completeImage: UIImage?
    
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var completeImageView: UIImageView!
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafeMutablePointer<Void>) {
        //didFinishSaving
        loadingView.hidden = true
        
        if (error == nil) {
            
            saveButton.setTitle("Saved", forState: UIControlState.Disabled)
            saveButton.enabled = false
            
            self.resetScroller = true
            
            //println("no error")
        } else {
            print("error saving image")
        }
    }
    
    
    @IBAction func facebookButtonTapped(sender: AnyObject) {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            //println("signed in. segue to comment")
            performSegueWithIdentifier("shareToComment", sender: self)
        } else {
            //println("not signed in. segue to sign in")
            performSegueWithIdentifier("shareToSignIn", sender: self)
        }
    }
    @IBAction func saveImage(sender: AnyObject) {
        //save image to photo roll
        loadingView.hidden = false
        
        UIImageWriteToSavedPhotosAlbum(self.completeImage!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeImageView.image = self.completeImage
        
        // Do any additional setup after loading the view.
    }
    var hokieImageScroller: HokieImageViewsScroller?
    override func viewDidAppear(animated: Bool) {
        completeImageView.image = self.completeImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var resetScroller: Bool = false
    //MARK: navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "shareToComment" {
            
            let destinationViewController = segue.destinationViewController as! CommentViewController
            destinationViewController.backgroundImage = self.completeImage
            
            
        } else if segue.identifier == "shareToCamera" {
            let destinationViewController = segue.destinationViewController as! CameraViewController
            
            if !self.resetScroller {
                //set the page and position of the hokieImageViewsScroller
                //destinationViewController.loadFromScroller = true
                destinationViewController.hokieImageViewsScroller = self.hokieImageScroller
            } else {
                //destinationViewController.loadFromScroller = false
            }
        }
    }

}
