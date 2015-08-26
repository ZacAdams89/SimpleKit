//
//  SimplicityUIEdgeInsets.swift
//  Giggle
//
//  Created by Zac Adams on 19/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation
import UIKit



extension UIEdgeInsets{
    
    static func topInset(top: CGFloat) -> UIEdgeInsets{
        return UIEdgeInsets(top: top, right: 0, bottom: 0, left: 0);
    }
    
    static func rightInset(right: CGFloat) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, right: right, bottom: 0, left: 0);
    }
    
    
    static func bottomInset(bottom: CGFloat) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, right: 0, bottom: bottom, left: 0);
    }
    
    static func leftInset(left: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, right: 0, bottom: 0, left: left);
    }
    
    
    static func horizontalInsets(inset: CGFloat) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, right: inset, bottom: 0, left: inset);
    }
    
    
    func verticleInsets(inset: CGFloat) -> UIEdgeInsets{
        return UIEdgeInsets(top: inset, right: 0, bottom: inset, left: 0);
    }
    
    init(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat){
        self.top = top;
        self.right = right;
        self.bottom = bottom;
        self.left = left;
    }
}
