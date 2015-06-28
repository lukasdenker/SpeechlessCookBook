//
//  LDAnimationElement.swift
//  SpeechlessCookBook
//
//  Created by Lukas on 28.06.15.
//  Copyright (c) 2015 Lukas. All rights reserved.
//

import UIKit

class LDAnimationElement: UIView {
    
    
    init(name:String, animationDirection:AnimationDirection, distance:Int) {
        
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    required init(coder aDecoder: NSCoder) {

        super.init()
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
