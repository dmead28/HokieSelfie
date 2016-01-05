//
//  HSSpecialImages.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 9/2/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class HSImageFactory: AnyObject {
    //TODO: Rename to HSImageViewFactory
    //TODO: Reword image to imageview
    
    //Singleton - private init
    private init() {
        //nothing
    }
    
    //Singleton - instance
    private let instance = HSImageFactory()
    func getInstance() -> HSImageFactory {
        return instance
    }
    
    //MARK: Special Images
    //week dates
    static let weekStarts = [
        "09/08/15",
        "09/13/15",
        "09/20/15",
        "09/27/15",
        "10/04/15",
        "10/11/15",
        "10/18/15",
        "10/25/15",
        "11/1/15",
        "11/14/15",
        "11/22/15",
        "11/29/15"
    ]

    
    private static func weekForDate(date: NSDate) -> Int {
        
        let laterDateFormatter = NSDateFormatter()
        laterDateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        for (var i=0; i < weekStarts.count; i++) {
            let laterDate = laterDateFormatter.dateFromString(weekStarts[i])
            
            if date.compare(laterDate!) == NSComparisonResult.OrderedAscending {
                return i
            }
        }
        
        return 12
    }
    
    //color and text
    static let colorAndTextArr = [
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "OSU"),
            HSColorAndText(topColor: UIColor.redColor(), bottomColor: UIColor.grayColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "FURMAN"),
            HSColorAndText(topColor: UIColor.purpleColor(), bottomColor: UIColor.grayColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "PURDUE"),
            HSColorAndText(topColor: UIColor.blackColor(), bottomColor: UIColor.yellowColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "ECU"),
            HSColorAndText(topColor: UIColor.purpleColor(), bottomColor: UIColor.yellowColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "PITT"),
            HSColorAndText(topColor: UIColor.blueColor(), bottomColor: UIColor.yellowColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "NC STATE"),
            HSColorAndText(topColor: UIColor.redColor(), bottomColor: UIColor.blackColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "THE U"),
            HSColorAndText(topColor: UIColor.orangeColor(), bottomColor: UIColor.greenColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "DUKE"),
            HSColorAndText(topColor: UIColor.blueColor(), bottomColor: UIColor.grayColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "BC"),
            HSColorAndText(topColor: UIColor.redColor(), bottomColor: UIColor.yellowColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "GT"),
            HSColorAndText(topColor: UIColor.yellowColor(), bottomColor: UIColor.grayColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "UNC"),
            HSColorAndText(topColor: UIColor.blueColor(), bottomColor: UIColor.blackColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "BEAT", bottomText: "UVA"),
            HSColorAndText(topColor: UIColor.blueColor(), bottomColor: UIColor.orangeColor(), topText: "Let's GO", bottomText: "HO-KIES")
        ],
        [
            HSColorAndText(topColor: UIColor(red: 145.0/255.0, green: 9.0/255.0, blue: 47.0/255.0, alpha: 100.00), bottomColor: UIColor(red: 207.0/255.0, green: 83.0/255.0, blue: 0.0/255.0, alpha: 100.0), topText: "Let's GO", bottomText: "HO-KIES")
        ]
    ]
    
    //get special images
    static func specialImageRowForWeek(weekNum: Int, frame: CGRect) -> [UIImageView] {
        var outputArr: [UIImageView] = []
        
        let currentWeekColorAndTexts = colorAndTextArr[weekNum]
        
        for (var i=0; i < currentWeekColorAndTexts.count; i++) {
            let currentImageView = DMTextStripeImageView(colorAndText: currentWeekColorAndTexts[i], frame: frame)
            outputArr.append(currentImageView)
        }
        
        return outputArr
    }
    
    static func specialImageRowForCurrentWeek(frame: CGRect) -> [UIImageView] {
        /*
        //debug
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let date = dateFormatter.dateFromString("12/29/15")
        */
        return self.specialImageRowForWeek(weekForDate(NSDate()), frame: frame)
    }
    
}
