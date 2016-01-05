//
//  DMTextStripeImageView.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 7/10/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class DMTextStripeImageView: UIImageView {
    //TODO: fix hokieImageViewsScroller to change the frame when the imageview is added. Probobly should make it also taek UIImages as argument and do the view wrapper in the scroller.
    
    private var topColor: UIColor?
    private var bottomColor: UIColor?
    
    private var topText: String?
    private var bottomText: String?
    
    private var topFrame: CGRect?
    private var bottomFrame: CGRect?
    
    var topView: UIView?
    var bottomView: UIView?
    
    var colorsImage: UIImage?
    var textImage: UIImage?

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        //println("DMTextStripeImageView.drawRect()")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //println("DMTextStripeImageView.initFrame()")
        
        topFrame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height/2)
        bottomFrame = CGRect(x: 0.0, y: frame.height/2, width: frame.width, height: frame.height/2)
        
        self.topView = UIView(frame: topFrame!)
        self.bottomView = UIView(frame: bottomFrame!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //println("DMTextStripeImageView.initCoder()")
    }
    
    convenience init(topColor: UIColor, bottomColor: UIColor, topText: String, bottomText: String, andFrame frame: CGRect) {
        self.init(colorAndText: HSColorAndText(topColor: topColor, bottomColor: bottomColor, topText: topText, bottomText: bottomText), frame: frame)
    }
    
    convenience init(colorAndText: HSColorAndText, frame: CGRect) {
        self.init(frame: frame)
        
        //println("init with top: \(topColor) and bottom: \(bottomColor)")
        
        self.setColors(colorAndText.topColor!, bottom: colorAndText.bottomColor!)
        self.setText(colorAndText.topText!, bottom: colorAndText.bottomText!)
        
        self.addSubview(self.topView!)
        self.addSubview(self.bottomView!)
    }
    
    func setColors(top: UIColor, bottom: UIColor) {
        
        UIGraphicsBeginImageContext(CGSize(width: topFrame!.width, height: topFrame!.height * 2.0))
        
        let ctx = UIGraphicsGetCurrentContext()
        
        CGContextSetAlpha(ctx, 0.50)
        CGContextSetFillColorWithColor(ctx, top.CGColor)
        CGContextFillRect(ctx, topFrame!)
        CGContextSetFillColorWithColor(ctx, bottom.CGColor)
        CGContextFillRect(ctx, bottomFrame!)
        //CGContextSetAlpha(ctx, 0.50)
        
        self.colorsImage = UIGraphicsGetImageFromCurrentImageContext()
        self.textImage?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    func setText(top: String, bottom: String) {
        
        UIGraphicsBeginImageContext(CGSize(width: topFrame!.width, height: topFrame!.height * 2.0))
        
        let ctx = UIGraphicsGetCurrentContext()
        
        let topText = UILabel(frame: topFrame!)
        let bottomText = UILabel(frame: bottomFrame!)
        
        topText.text = top
        bottomText.text = bottom
        
        topText.textColor = UIColor.whiteColor()
        bottomText.textColor = UIColor.whiteColor()
        
        topText.textAlignment = .Center
        bottomText.textAlignment = .Center
        
        topText.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        bottomText.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        
        topText.font = UIFont(name: "Helvetica", size: 200.0)
        bottomText.font = UIFont(name: "Helvetica", size: 200.0)
        
        topText.adjustsFontSizeToFitWidth = true
        bottomText.adjustsFontSizeToFitWidth = true
        
        topText.drawTextInRect(topFrame!)
        bottomText.drawTextInRect(bottomFrame!)
        
        /*
        var foo = UILabel(frame: topFrame!)
        foo.text = "HEY"
        foo.textAlignment = NSTextAlignment.Center
        foo.sizeThatFits(CGSize(width: topFrame!.width, height: topFrame!.height))
        foo.drawTextInRect(topFrame!)
        
        //topText.drawInRect(topFrame!, withAttributes: nil)
        bottomText.drawInRect(bottomFrame!, withAttributes: nil)
        */
        self.textImage = UIGraphicsGetImageFromCurrentImageContext()
        self.colorsImage?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.textImage?.drawInRect(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }

}
