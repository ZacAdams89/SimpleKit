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
        return entityName()
    }
    
    func className() -> String{
        return NSStringFromClass(type(of: self))
    }
    
    fileprivate func objcast<T>(_ obj: AnyObject) -> T {
        return obj as! T
    }

    func objcast<T>(_ obj: AnyObject?) -> T? {
        return obj as! T?
    }
    
    class func entityName() -> String {
        let classString = NSStringFromClass(self)
        // The entity is the last component of dot-separated class name:
        let components = classString.characters.split { $0 == "." }.map { String($0) }
        return components.last ?? classString
    }
}
