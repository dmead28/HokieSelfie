//
//  HorizontalScrollView.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 4/18/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import UIKit

class HorizontalScrollView: UIScrollView {
    var imageCount = 0
    
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
    
    var imageViews = [UIImageView]()
    
    func addUIImageView(newImageView: UIImageView) {
        let imageContainer = UIView(frame: CGRectMake(self.contentSize.width, 0, self.frame.width, self.frame.height))
        
        imageContainer.addSubview(newImageView)
        
        imageContainer.contentMode = UIViewContentMode.Center
        imageContainer.clipsToBounds = true
        
        self.addSubview(imageContainer)
        
        imageViews.append(newImageView)
        imageCount++
        
        self.contentSize = CGSize(width: self.frame.width * CGFloat(imageCount), height: self.frame.height)
    }
    
    func getHokieImageView(atIndex: Int) -> UIImageView {
        return imageViews[atIndex]
    }
    
}