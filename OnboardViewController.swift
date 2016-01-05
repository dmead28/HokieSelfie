//
//  OnboardViewController.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 7/19/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class OnboardViewController: UIViewController {
    
    @IBOutlet weak var pylonImageView: UIImageView!
    @IBOutlet weak var vtOrangeImageView: UIImageView!
    
    @IBOutlet weak var completeText: UILabel!
    @IBOutlet weak var previewView: UIImageView!
    
    var cameraView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //load camera from previous screen (signIn)
        if cameraView != nil {
            self.view.insertSubview(cameraView!, atIndex: 0)
        } //if did not receive, do nothing. Will just be an orange background. Don't want to use resources to load camera again, since it wont even really be seen.
        
        setupAnimations()
    }
    
    //MARK: Animations
    func setupAnimations() {
        //defaults
        let previewViewFrame = self.previewView.frame
        let previewViewCenter = self.previewView.center
        
        //UIImages
        let arrowLeftRightHorizontal = UIImage(named: "ArrowLeftRight")
        let arrowRotate = UIImage(named: "ArrowRotate")
        
        //user simulation views
        let userSimulationContainer = UIImageView(frame: CGRect(x: previewViewFrame.minX, y: previewViewCenter.y - (previewViewFrame.height / 10), width: previewViewFrame.width, height: previewViewFrame.height / 5))
        //userSimulationContainer.backgroundColor = UIColor.blackColor() //for debugging
        userSimulationContainer.image = arrowLeftRightHorizontal
        userSimulationContainer.alpha = 0.0
        
        let userRotationSimulationContainer = UIImageView(frame: CGRect(x: previewViewFrame.minX, y: previewViewCenter.y - (previewViewFrame.height / 10), width: previewViewFrame.width, height: previewViewFrame.height / 5))
        //userHorizontalSwipeSimulationContainer.image = UIColor.blackColor() //for debugging
        userRotationSimulationContainer.image = arrowRotate
        userRotationSimulationContainer.alpha = 0.0
        
        let userHorizontalSwipeSimulationContainer = UIImageView(frame: CGRect(x: previewViewFrame.minX, y: self.view.frame.maxY - (previewViewFrame.height * 2 / 5), width: previewViewFrame.width, height: previewViewFrame.height / 5))
        //userHorizontalSwipeSimulationContainer.image = UIColor.blackColor() //for debugging
        userHorizontalSwipeSimulationContainer.image = arrowLeftRightHorizontal
        userHorizontalSwipeSimulationContainer.alpha = 0.0
        
        //TODO: figure out a better way to rotate this without setting the frame twice
        let userVerticalSwipeSimulationContainer = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: previewViewFrame.width, height: previewViewFrame.height / 5))
        //println("x: \(0.0) y: \(self.view.frame.maxY - (previewViewFrame.height * 2 / 5)) width: \(previewViewFrame.width) height: \(previewViewFrame.height / 5))")
        userVerticalSwipeSimulationContainer.transform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(M_PI/2.0))
        userVerticalSwipeSimulationContainer.frame = CGRect(x: 0.0, y: previewViewCenter.y - (userVerticalSwipeSimulationContainer.frame.height / 2), width: userVerticalSwipeSimulationContainer.frame.width, height: userVerticalSwipeSimulationContainer.frame.height)
        //userVerticalSwipeSimulationContainer.backgroundColor = UIColor.blackColor() //for debugging
        userVerticalSwipeSimulationContainer.image = arrowLeftRightHorizontal
        userVerticalSwipeSimulationContainer.alpha = 0.0
        
        //offscreen frame set
        vtOrangeImageView.frame = CGRect(x: previewViewFrame.minX + self.view.frame.width, y: vtOrangeImageView.frame.minY, width: vtOrangeImageView.frame.width, height: vtOrangeImageView.frame.height)
        vtOrangeImageView.hidden = false
        pylonImageView.frame = CGRect(x: pylonImageView.frame.minX, y: previewViewFrame.minY + self.view.frame.height, width: pylonImageView.frame.width, height: pylonImageView.frame.height)
        pylonImageView.hidden = false
        
        //offscreen defaults
        let vtOrangeFrame = vtOrangeImageView.frame
        let pylonFrame = pylonImageView.frame
        
        //animation constants
        let duration = 7.5
        let delay = 0.0
        
        //println("Width: \(userSimulationContainer.frame.width) and Height: \(userSimulationContainer.frame.height)")
        
        //animate the instructions
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: [.Repeat, .AllowUserInteraction], animations: {
            () -> Void in
            
            //upzoom
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/14, animations: {
                self.view.addSubview(userSimulationContainer)
                userSimulationContainer.alpha = 1.0
                self.previewView.frame = CGRect(x: previewViewCenter.x - (previewViewFrame.width * 0.6), y: previewViewCenter.y - (previewViewFrame.height * 0.6), width: previewViewFrame.width * 1.2, height: previewViewFrame.height * 1.2)
            })
            
            //down zoom
            UIView.addKeyframeWithRelativeStartTime(1/14, relativeDuration: 1/14, animations: {
                //let previewViewFrame = self.previewView.frame
                userSimulationContainer.alpha = 0.0
                self.previewView.frame = CGRect(x: previewViewFrame.minX, y: previewViewFrame.minY, width: previewViewFrame.width, height: previewViewFrame.height)
            })
            
            //down alpha
            UIView.addKeyframeWithRelativeStartTime(2/14, relativeDuration: 2/14, animations: {
                self.view.addSubview(userRotationSimulationContainer)
                //do rotate animation
                userRotationSimulationContainer.alpha = 1.0
                self.previewView.alpha = 0.5
            })
            
            //up alpha
            UIView.addKeyframeWithRelativeStartTime(4/14, relativeDuration: 2/14, animations: {
                //do rotate animation
                userRotationSimulationContainer.alpha = 0.0
                self.previewView.alpha = 1.0
            })
            
            //swipe vertical up
            UIView.addKeyframeWithRelativeStartTime(6/14, relativeDuration: 2/14, animations: {
                //do swipe animation
                self.previewView.frame = CGRect(x: previewViewFrame.minX, y: -previewViewFrame.maxY, width: previewViewFrame.width, height: previewViewFrame.height)
                self.pylonImageView.frame = CGRect(x: pylonFrame.minX, y: previewViewFrame.minY, width: pylonFrame.width, height: pylonFrame.height)
                self.view.addSubview(userVerticalSwipeSimulationContainer)
                userVerticalSwipeSimulationContainer.alpha = 1.0
            })
            
            //swipe vertical down
            UIView.addKeyframeWithRelativeStartTime(8/14, relativeDuration: 2/14, animations: {
                //do swipe animation
                self.previewView.frame = previewViewFrame
                self.pylonImageView.frame = pylonFrame
                userVerticalSwipeSimulationContainer.alpha = 0.0
            })
            
            //swipe horizontal left
            UIView.addKeyframeWithRelativeStartTime(10/14, relativeDuration: 2/14, animations: {
                //do swipe animation
                self.previewView.frame = CGRect(x: -previewViewFrame.maxX, y: previewViewFrame.minY, width: previewViewFrame.width, height: previewViewFrame.height)
                self.vtOrangeImageView.frame = CGRect(x: previewViewFrame.minX, y: vtOrangeFrame.minY, width: vtOrangeFrame.width, height: vtOrangeFrame.height)
                self.view.addSubview(userHorizontalSwipeSimulationContainer)
                userHorizontalSwipeSimulationContainer.alpha = 1.0
            })
            
            //swipe horizontal right
            UIView.addKeyframeWithRelativeStartTime(12/14, relativeDuration: 2/14, animations: {
                //do swipe animation
                self.previewView.frame = previewViewFrame
                self.vtOrangeImageView.frame = vtOrangeFrame
                userHorizontalSwipeSimulationContainer.alpha = 0.0
            })
            
            }, completion: nil)
        
        //animation complete text and enable segue
        UIView.animateWithDuration(0.01, delay: duration, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.completeText.alpha = 1.0
            }, completion: { (finished) -> Void in
                if (finished) {
                    self.tapGestureRecognizer.enabled = true
                }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBAction func userTappedAnywhere(sender: AnyObject) {
        //println("onboard to camera")
        
        //set user default to prevent this from showing again
        //NSUserDefaults.standardUserDefaults().setBool(false, forKey: "FirstLaunch")
        NSUserDefaults.standardUserDefaults().setInteger(InitialViewController.BUILD_NUM, forKey: "buildNum")
        
        //segue to camera
        performSegueWithIdentifier("onboardToCamera", sender: self)
    }

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
