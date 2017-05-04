//
//  SimpleKitFoundation.swift
//  Giggle
//
//  Created by Zac Adams on 31/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation


func SimpleKitStringFromClass(_ aClass: AnyClass!) -> String!{
    let classString = NSStringFromClass(aClass)
    // The entity is the last component of dot-separated class name:
    let components = classString.characters.split { $0 == "." }.map { String($0) }
    return components.last ?? classString
}
