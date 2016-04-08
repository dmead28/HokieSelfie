//
//  ViewController.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 4/16/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class CameraViewController: UIViewController, UIGestureRecognizerDelegate, CameraPreviewViewDelegate {
    
    //MARK: Buttons and Layout
    @IBOutlet weak var topBar: UIVisualEffectView!
    @IBOutlet weak var frontBackButton: UIButton!
    @IBAction func frontBackButton(sender: AnyObject) {
        //toggle front or back camera
        //println("toggle front or back camera")
        
        previewView?.toggleFrontBack()
    }
    @IBOutlet weak var facebookButton: UIButton!
    @IBAction func facebookButtonClicked(sender: AnyObject) {
        //sign in or sign out
    }
    
    var previewView: CameraPreviewView?
    
    //MARK: Capture image
    //camera output variables
    //var outputImageContainerView: UIView? //unused?
    var completeImage: UIImage? //declared as property for use in segues
    
    @IBAction func handleClickAnywhere(sender: AnyObject) {
        
        //captureCompleteImage() //and segue to ShareViewController
        
        previewView?.captureImage() //TODO: should use a block here maybe?
    }
    
    func imageDidCapture(image: UIImage) {
        //println("didCaptureImage")
        
        //find correct hokieImageView
        if let hokieImageView = self.hokieImageViewsScroller!.getCurrentHokieImageView() {
            //get composite UIImage
            //self.completeImage = self.compositeImage(image, image2View: hokieImageView)
            self.compositeImage(backgroundImage: hokieImageView.image!, foregroundImage: hokieImageView.image!, foregroundImageAlpha: hokieImageView.alpha, coordinates: CGPoint(x: hokieImageView.frame.minX, y: hokieImageView.frame.minY), onComplete: {
                [weak self] (finalImage: UIImage) in
                
                //create UIImageView
                /*
                let completeImageView = UIImageView(image: finalImage)
                completeImageView.frame = self.view.frame
                */
                
                //segue to the ShareViewController (will use self.completeImage)
                self?.completeImage = finalImage
                self?.performSegueWithIdentifier("cameraToShare", sender: self)
                
            })
            
        } else {
            print("Error: hokieImageViews not defined in CameraViewController.captureCompleteImage()\nPossibly need to wait for download of images.")
        }

    }
    
    func compositeImage(backgroundImage backgroundImage: UIImage, foregroundImage: UIImage, foregroundImageAlpha alpha: CGFloat, coordinates: CGPoint, onComplete: (finalImage: UIImage) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            UIGraphicsBeginImageContext(foregroundImage.size)
            
            let ctx = UIGraphicsGetCurrentContext()
            
            CGContextSetAlpha(ctx, alpha)
            CGContextDrawImage(ctx, CGRect(x: 0, y: 0, width: foregroundImage.size.width, height: foregroundImage.size.height), foregroundImage.CGImage)
            
            let tempImage = UIGraphicsGetImageFromCurrentImageContext()
            
            let foregroundImageAlpha = UIImage(CGImage: tempImage.CGImage!, scale: 1.0, orientation: UIImageOrientation.DownMirrored)
            
            UIGraphicsEndImageContext()
            
            //combine image2Alpha and image1 (camera photo)
            UIGraphicsBeginImageContext(CGSize(width: self.view.frame.width, height: self.view.frame.height))
            
            backgroundImage.drawInRect(CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            foregroundImageAlpha.drawInRect(CGRect(x: coordinates.x, y: coordinates.y, width: foregroundImage.size.width, height:  foregroundImage.size.height))
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            dispatch_async(dispatch_get_main_queue(), {
                onComplete(finalImage: newImage)
            })
            
        })
    }
    
    func compositeImage(image1: UIImage, image2View: UIImageView) -> UIImage {
        
        var image2 = image2View.image as UIImage!
        
        //make image2Alpha: image2 with alpha settings determined by user
        UIGraphicsBeginImageContext(CGSize(width: image2View.frame.width, height: image2View.frame.height))
        
        let ctxA = UIGraphicsGetCurrentContext()
        
        CGContextSetAlpha(ctxA, image2View.alpha)
        CGContextDrawImage(ctxA, CGRect(x: 0, y: 0, width: image2View.frame.width, height: image2View.frame.height), image2.CGImage)
        
        let tempImage = UIGraphicsGetImageFromCurrentImageContext()
        
        let image2Alpha = UIImage(CGImage: tempImage.CGImage!, scale: 1.0, orientation: UIImageOrientation.DownMirrored)
        
        UIGraphicsEndImageContext()
        
        
        //combine image2Alpha and image1 (camera photo)
        UIGraphicsBeginImageContext(CGSize(width: self.view.frame.width, height: self.view.frame.height))
        
        image1.drawInRect(CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        image2Alpha.drawInRect(CGRect(x: image2View.frame.minX, y: image2View.frame.minY, width: image2View.frame.width, height:  image2View.frame.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    //MARK: Pinch gesture
    var width_0: CGFloat?
    var height_0: CGFloat?
    
    //var x0: CGFloat = 0
    //var y0: CGFloat = 0
    func userDidPinch(recognizer: UIPinchGestureRecognizer) {
        let imageView = recognizer.view as! UIImageView
        
        if recognizer.state == UIGestureRecognizerState.Began {
            height_0 = imageView.frame.height
            width_0 = imageView.frame.width
        }
        
        let scale = recognizer.scale
        let width = width_0! * scale
        let height = height_0! * scale
        
        /*
        //trying to solve the "jumping" problem as raise fingers (might just be me)
        let velocity = recognizer.velocity
        let x = recognizer.view?.frame.origin.x
        let y = recognizer.view?.frame.origin.y
        let vx = x! - x0
        let vy = y! - y0
        println("pinch with x: \(x!) y: \(y!) vx: \(vx) vy: \(vy)") //see if velocity spike present when "jumps"
        x0 = x!
        y0 = y!
        */
        let center = recognizer.locationInView(hokieImageViewsScroller)
        
        imageView.frame = CGRect(x: center.x - (width / 2), y: center.y - (height / 2), width: width, height: height)
        
        if recognizer.state == .Cancelled || recognizer.state == .Failed || recognizer.state == .Ended {
            //println(" pinch ended")
            height_0 = nil
            width_0 = nil
            
            animateIf(imageView, isOutOfBoundsOf: self.view, withVelocity: CGPoint(x: 0.0, y: 0.0))
        }
        
    }
    
    //MARK: Rotate gesture
    var alpha_0: CGFloat?
    func userDidRotate(recognizer: UIRotationGestureRecognizer) {
        let imageView = recognizer.view as! UIImageView
        
        if recognizer.state == UIGestureRecognizerState.Began {
            alpha_0 = imageView.alpha
        }
        
        let angle = recognizer.rotation
        let ninety: CGFloat = 3.14/4
        
        var percent = angle/ninety
        
        if percent > 1.0 {percent = 1.0}
        if percent < 0.0 {percent = 0.0}
        
        let dAlpha = angle/ninety
        var newAlpha = alpha_0! + dAlpha
        if newAlpha < 0.15 {newAlpha = 0.15}
        
        imageView.alpha = newAlpha
        
        if recognizer.state == .Cancelled || recognizer.state == .Failed || recognizer.state == .Ended {
            //println("rotate ended")
            alpha_0 = nil
        }
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKindOfClass(UIPinchGestureRecognizer) && otherGestureRecognizer.isKindOfClass(UIRotationGestureRecognizer) {
            return true
        } else if gestureRecognizer.isKindOfClass(UIRotationGestureRecognizer) && otherGestureRecognizer.isKindOfClass(UIPinchGestureRecognizer) {
            return true
        } else {
            return false
        }
    }
    
    //MARK: Pan gesture (move HokieImage)
    func moveUIImage(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        
        let newY = recognizer.view!.center.y + translation.y
        let newX = recognizer.view!.center.x + translation.x
        
        //update position while panning
        recognizer.view!.center = CGPoint(x: newX, y: newY)
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
        if recognizer.state != .Began && recognizer.state != .Changed {
            animateIf(recognizer.view!, isOutOfBoundsOf: self.view, withVelocity: recognizer.velocityInView(self.view))
        }
    }
    
    //MARK: Animate in bounds
    func animateIf(aView: UIView, isOutOfBoundsOf parent: UIView, withVelocity velocity: CGPoint) {
        //animation constants
        //let k: CGFloat = 1.0 //k - spring constant
        let t: CGFloat = 0.5
        
        //aView.frame properties
        let viewMinX = aView.frame.minX
        //var viewMaxX = aView.frame.maxX
        let viewMinY = aView.frame.minY
        //var viewMaxY = aView.frame.maxY
        
        //parent.frame properties
        var parentMinX = parent.frame.minX
        let parentMaxX = parent.frame.maxX
        var parentMinY = parent.frame.minY
        let parentMaxY = parent.frame.maxY
        
        //min and max relative to aView.frame minX and minY
        let minX = -(aView.frame.width * 3/4)
        let maxX = parentMaxX - (aView.frame.width * 1/4)
        let minY = topBar.frame.height - (aView.frame.height * 1/2)
        let maxY = parentMaxY - (aView.frame.height * 1/2)
        
        //new parameters to animate to
        if viewMinX > minX && viewMinX < maxX && viewMinY > minY && viewMinY < maxY {
            //println("in bounds x,y")
            //do nothing
        } else {
            //not in bounds. set new parameters and animate
            var newX = viewMinX
            var newY = viewMinY
            
            //if x is out of bounds
            if viewMinX < minX {
                //println("left of view")
                newX = minX
            } else if (viewMinX > maxX) {
                //println("right of view")
                newX = maxX
            }
            
            //if y is out of bounds
            if viewMinY < minY {
                //println("above view")
                newY = minY
            } else if (viewMinY > maxY) {
                //println("below view")
                newY = maxY
            }
            
            //set final position
            //let decelerationX = k * (aView.frame.minX - newX)
            //let decelerationY = k * (aView.frame.minY - newY)
            UIView.animateWithDuration(Double(t), delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                //println("animating with ")
                //let finalX = Double(newX) + (Double(-velocity.x) * t) + (decelerationX * (t * t))/2
                //let finalY = Double(newY) + (Double(-velocity.y) * t) + (decelerationY * (t * t))/2
                
                aView.frame = CGRect(x: newX, y: newY, width: aView.frame.width, height: aView.frame.height)
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
        
        
        
    }
    
    //@IBOutlet weak var hokieImageViewsScroller: HokieImageViewsScroller!
    
    //MARK: ViewController methods
    var hokieImageViews = [UIImageView]()
    var hokieImageViewsScroller: HokieImageViewsScroller?
    
    var hokieImageNames = [
        ["HBBoth", "HBMaroon", "HBOrange"],
        ["LPDBoth", "LPDMaroon", "LPDOrange"],
        ["vt_0", "vt_1"],
        ["pylon_0","pylon_1"]
    ]
    
    //viewDidLoad
    //@IBOutlet weak var clickAreaView: UIView!
    //var loadFromScroller: Bool = false //used to preserve state through transitions
    override func viewDidLoad() {
        //println("viewDidLoad")
        super.viewDidLoad()
        
        //if loadFromScroller == false {
        if hokieImageViewsScroller == nil {
            hokieImageViewsScroller = HokieImageViewsScroller(frame: self.view.frame)
            hokieImageViewsScroller!.delegate = self
            
            
            //add text strip view
            let DMTextStripeFrame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
            let newImage = HSImageFactory.specialImageRowForCurrentWeek(DMTextStripeFrame)
            hokieImageViewsScroller?.addImageViewsRow(fromArray: newImage)

            //add the rest
            for (var x=0; x<hokieImageNames.count; x++) {
                //for each row of hokieImages
                //println("iteration \(x)")
                var hokieImageViewsRow = [UIImageView]()
                
                for (var y=0; y<hokieImageNames[x].count; y++) {
                    //println("iteration \(x) and \(y) with name: \(hokieImageNames[x][y])")
                    let hokieImage = UIImage(named: hokieImageNames[x][y])
                    
                    let hokieImageView = UIImageView(image: hokieImage)
                    //hokieImageView.backgroundColor = UIColor.blackColor()
                    hokieImageView.contentMode = UIViewContentMode.ScaleAspectFit
                    
                    let newWidth = 2/3 * hokieImageViewsScroller!.frame.width
                    let newHeight = CGFloat((Double(hokieImage!.size.height) / Double(hokieImage!.size.width)) * Double(newWidth))
                    
                    hokieImageView.frame = CGRect(x: (hokieImageViewsScroller!.frame.width)/2 - newWidth/2, y: (hokieImageViewsScroller!.frame.height - topBar.frame.height)/2 - newHeight/2 + topBar.frame.height, width: newWidth, height: newHeight)
                    //TODO: stripe text image views aren't userInteractionEnabled because they are full screen
                    hokieImageView.userInteractionEnabled = true
                    
                    hokieImageViews.append(hokieImageView)
                    hokieImageViewsRow.append(hokieImageView)
                }
                
                hokieImageViewsScroller?.addImageViewsRow(fromArray: hokieImageViewsRow)
                
            }
        } //else it will load from the hokieImageViewsScroller that was passed back from the ShareViewController
        
        //TODO: set up the camera only if last viewController didn't pass it on
        //set up the camera
        //setUpCamera(AVCaptureDevicePosition.Front)
        if previewView == nil {
            previewView = CameraPreviewView(frame: self.view.frame, delegate: self)
        } else {
            previewView!.delegate = self
        }
        self.view.addSubview(previewView!)
        previewView!.start()
        
        //little cleaning up
        self.view.addSubview(hokieImageViewsScroller!)
        self.view.bringSubviewToFront(topBar)
        //self.view.bringSubviewToFront(clickAreaView)
        
        //MARK: taking picture
        let tapGestureRecognizer = UITapGestureRecognizer(target: previewView!, action: "captureImage")
        hokieImageViewsScroller?.addGestureRecognizer(tapGestureRecognizer)
        
        //println("Count of subviews: \(self.view.subviews.count)")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //println("viewDidAppear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        previewView?.suspend()
        previewView?.start()
    }
    
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cameraToShare" {
            //println("camera to share")
            
            self.previewView?.suspend()
            
            let destinationViewController = segue.destinationViewController as! ShareViewController
            destinationViewController.completeImage = self.completeImage
            destinationViewController.hokieImageScroller = self.hokieImageViewsScroller
        }
    }
    
}

