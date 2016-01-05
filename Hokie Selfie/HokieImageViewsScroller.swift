//
//  HokieImagesView.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 5/21/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class HokieImageViewsScroller: UIView, UIScrollViewDelegate {
    
    var activeHokieImageView: UIImageView? //output UIImageView for the compositeImage func
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //set up the HokieImages
        verticleScroller = VerticleScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        verticleScroller!.delegate = self
        
        self.addSubview(verticleScroller!)
    }
    
    var verticleScroller: VerticleScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //set up the HokieImages
        verticleScroller = VerticleScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        verticleScroller!.delegate = self
        
        self.addSubview(verticleScroller!)
    }
    
    
    var delegate: UIViewController?
    func addImageViewsRow(fromArray imageViewRow: [UIImageView]) {
        
        let horizontalScroller = HorizontalScrollView(frame: self.frame)
        horizontalScroller.delegate = self
        
        for (var z=0; z<imageViewRow.count; z++) {
            let currentImageView = imageViewRow[z]
            
            if let del = self.delegate {
                let moveUIImageGesture = UIPanGestureRecognizer(target: del, action: "moveUIImage:")
                let pinchGestureRecognizer = UIPinchGestureRecognizer(target: del, action: "userDidPinch:")
                let rotateGestureRecognizer = UIRotationGestureRecognizer(target: del, action: "userDidRotate:")
                
                pinchGestureRecognizer.delegate = del as? UIGestureRecognizerDelegate
                rotateGestureRecognizer.delegate = del as? UIGestureRecognizerDelegate
                
                currentImageView.addGestureRecognizer(moveUIImageGesture)
                currentImageView.addGestureRecognizer(pinchGestureRecognizer)
                currentImageView.addGestureRecognizer(rotateGestureRecognizer)
            } else {
                //println("Error: delegate not set in HokieImagesView")
            }
            
            horizontalScroller.addUIImageView(currentImageView)
        }
        
        verticleScroller!.addHorizontalScrollView(toBottom: horizontalScroller)
        
        self.layoutIfNeeded()
    }
    
    func getCurrentHokieImageView() -> UIImageView? {
        let horizontalScrollView = verticleScroller!.getHorizontalScrollView(Int(self.pageY))
        
        let hokieImageView = horizontalScrollView.getHokieImageView(Int(self.pageX))
        
        return hokieImageView
    }
    
    var pageX = CGFloat(0.0)
    var pageY = CGFloat(0.0)
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("end")
        
        if scrollView.isKindOfClass(HorizontalScrollView) {
            let horizontalScrollView = scrollView as! HorizontalScrollView
            let offsetX = scrollView.contentOffset.x
            horizontalScrollView.page =  offsetX / self.frame.width
            
            pageX = horizontalScrollView.page
        } else if scrollView.isKindOfClass(VerticleScrollView) {
            let verticleScrollView = scrollView as! VerticleScrollView
            let offsetY = scrollView.contentOffset.y
            verticleScrollView.page = offsetY / self.frame.height
            
            pageY = verticleScrollView.page
            pageX = verticleScrollView.getHorizontalScrollView(Int(pageY)).page
        }
        
        print("pageX: \(pageX) pageY: \(pageY)")
    }

    
    /*
    //not being used
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //nothing
    }
    */
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
