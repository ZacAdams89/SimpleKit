//
//  NSObject.swift
//  Giggle
//
//  Created by Zac Adams on 25/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation


extension NSObject{
    
    class func className() -> String{
        return NSStringFromClass(self)
    }
    
    func className() -> String{
        return NSStringFromClass(self.dynamicType)
    }
    
}