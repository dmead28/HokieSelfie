//
//  TestViewController.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 8/10/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, CameraPreviewViewDelegate {

    @IBAction func userDidClickButton(sender: AnyObject) {
        println("Clicked")
        previewView?.captureImage()
    }
    
    var previewView: CameraPreviewView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        previewView = CameraPreviewView(frame: self.view.frame, delegate: self)
        previewView!.delegate = self
        self.view.insertSubview(previewView!, atIndex: 0)
        previewView!.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageDidCapture(image: UIImage) {
        println("Captured Image successfully")
        let imageView = UIImageView(image: image)
        self.view.addSubview(imageView)
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
