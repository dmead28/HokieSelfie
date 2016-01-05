//
//  TestColorsViewController.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 7/10/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class TestColorsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //println("test")
        
        let hokieStripeTextA = DMTextStripeImageView(frame: CGRect(x: 5, y: 5, width: 5, height: 5))
        let hokieStripeTextB = DMTextStripeImageView(topColor: UIColor.redColor(), bottomColor: UIColor.blueColor(), topText: "Hey", bottomText: "Bottom", andFrame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(hokieStripeTextA)
        self.view.addSubview(hokieStripeTextB)
        
        hokieStripeTextA.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
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

}
