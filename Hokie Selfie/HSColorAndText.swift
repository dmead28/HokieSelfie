//
//  HSColorAndText.swift
//  Hokie Selfie
//
//  Created by Douglas Mead on 9/2/15.
//  Copyright (c) 2015 Ok Doug. All rights reserved.
//

import Foundation

//Struct
struct HSColorAndText {
    var topColor: UIColor?
    var bottomColor: UIColor?
    var topText: String?
    var bottomText: String?
    init(topColor: UIColor, bottomColor: UIColor, topText: String, bottomText: String) {
        self.topColor = topColor
        self.bottomColor = bottomColor
        self.topText = topText
        self.bottomText = bottomText
    }
}