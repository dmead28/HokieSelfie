//
//  CommentViewController.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 5/17/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITextViewDelegate, FBSDKSharingDelegate, UIAlertViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textInputView: UITextView!
    @IBOutlet weak var textDefaultView: UITextView!
    
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var postButton: UIView!
    
    @IBOutlet weak var loadingView: UIView!
    var backgroundImage: UIImage?
    
    @IBAction func clearText(sender: AnyObject) {
        textInputView.text = ""
        
        textDefaultView.alpha = 1
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        //println("editing")
    }
    func textViewDidChange(textView: UITextView) {
        if textInputView.text.characters.count > 0 {
            textDefaultView.alpha = 0
        } else {
            textDefaultView.alpha = 1
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                textViewBottomConstraint.constant = keyboardHeight + CGFloat(20.0)
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    var completeImage: UIImage?
    
    func postToFacebook() {
        
        //println("posting to facebook")
        
        loadingView.hidden = false
        
        let image = self.completeImage
        
        let content = FBSDKSharePhotoContent()
        
        let postImage = FBSDKSharePhoto(image: image, userGenerated: true)
        postImage.caption = textInputView.text
        
        content.photos = [postImage]
        
        FBSDKShareAPI.shareWithContent(content as FBSDKSharePhotoContent, delegate: self)
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        loadingView.hidden = true
        performSegueWithIdentifier("commentToShare", sender: self)
        //println("complete")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        loadingView.hidden = true
        
        let alert = UIAlertView(title: "Post Failed", message: "Could not post due to unknown error. Sign in to facebook or try again.", delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
        //performSegueWithIdentifier("commentToShare", sender: self)
        print("failed")
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        loadingView.hidden = true
        print("cancelled")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)

        imageView.image = backgroundImage!
        completeImage = backgroundImage!
        
        textView.delegate = self
        textView.becomeFirstResponder()
        
        let postButtonTap = UITapGestureRecognizer(target: self, action: "postToFacebook")
        postButton.addGestureRecognizer(postButtonTap)
        self.view.bringSubviewToFront(postButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "commentToShare" {
            let destinationViewController = segue.destinationViewController as! ShareViewController
            destinationViewController.completeImage = self.backgroundImage
            destinationViewController.resetScroller = true
        }
    }

}
