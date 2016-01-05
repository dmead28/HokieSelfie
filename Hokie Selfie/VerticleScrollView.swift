//
//  DMScroller.swift
//  Mettero
//
//  Created by Douglas Mead on 4/10/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class VerticleScrollView: UIScrollView {
    
    
    var clearImageSnapButton: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var imageCount = 1
    var horizontalScrollViewCount = 0
    
    var page = CGFloat(0.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var horizontalScrollViews = [HorizontalScrollView]()
    
    func addHorizontalScrollView(toBottom newHorizontalScrollView: HorizontalScrollView) {
        //adds a new horizontal scroll view below any current ones
        
        //set horizontalScrollView frame to y position = contentSize height
        newHorizontalScrollView.frame = CGRect(x: 0, y: self.contentSize.height, width: self.frame.width, height: self.frame.height)
        
        //add horizontalScrollView as a subview
        self.addSubview(newHorizontalScrollView)
        horizontalScrollViews.append(newHorizontalScrollView)
        
        //adjust content size
        horizontalScrollViewCount++
        self.contentSize = CGSize(width: self.frame.width, height: self.frame.height * CGFloat(horizontalScrollViewCount))
    }
    
    func getHorizontalScrollView(atIndex: Int) -> HorizontalScrollView {
        return horizontalScrollViews[atIndex]
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
}
