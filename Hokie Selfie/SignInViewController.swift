//
//  SignInViewController.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 4/18/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit
import AVFoundation

class SignInViewController: UIViewController, FBSDKLoginButtonDelegate {
    /*
    //MARK: camera
    //cameraSetUp variables
    var captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var output: AVCaptureStillImageOutput?
    //outputView (place under the blur areas)
    
    var cameraView: UIView?
    
    func setUpCamera() {
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == AVCaptureDevicePosition.Front) {
                    captureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        var error: NSError?
        var input = AVCaptureDeviceInput(device: captureDevice, error: &error)
        
        if error == nil && captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        
        
        var output = AVCaptureStillImageOutput()
        output.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        captureSession.addOutput(output)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = self.view.frame
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        captureSession.startRunning()
    }
    */
    //MARK: facebook login
    func setUpFacebook() {
        //add login button programmatically
        let loginButton = FBSDKLoginButton()
        loginButton.frame = CGRect(origin: CGPoint(x: self.view.frame.width / 2 - 50, y: self.view.frame.height * (2/3)), size: CGSize(width: 100, height: 50))
        
        loginButton.readPermissions = ["public_profile"]
        loginButton.publishPermissions = ["publish_actions"]
        
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        //println("signed in")
        
        //go to onboard since this may be a different user
        performSegueWithIdentifier("signInToOnboard", sender: self)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        //println("signed out")
    }
    
    //MARK: segue without facebook
    @IBAction func segueToCamera(sender: AnyObject) {
        let firstLaunch = InitialViewController.shouldGoToOnbooard()
        if !firstLaunch  {
            //if not first use
            //println("Not first launch.")
            performSegueWithIdentifier("signInToCamera", sender: self)
        }
        else {
            //else, go to onboard
            //println("First launch, setting NSUserDefault.")
            performSegueWithIdentifier("signInToOnboard", sender: self)
        }
    }
    
    //MARK: view controller methods
    var previewView: CameraPreviewView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize the camera
        //setUpCamera()
        previewView = CameraPreviewView(frame: self.view.frame)
        self.view.insertSubview(previewView!, atIndex: 0)
        //self.view.addSubview(previewView!)
        previewView!.start()
        
        //setup facebook
        setUpFacebook()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "signInToOnboard" {
            //println("sign in to onboard")
            
            let destinationViewController = segue.destinationViewController as! OnboardViewController
            destinationViewController.cameraView = self.previewView!
        } else if segue.identifier == "signInToCamera" {
            //println("sign in to camera")
            
            let destinationViewController = segue.destinationViewController as! CameraViewController
            destinationViewController.previewView = self.previewView!
        }
    }
    

}
