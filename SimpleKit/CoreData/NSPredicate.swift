//
//  Predicate.swift
//  Giggle
//
//  Created by Zac Adams on 25/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation

extension NSPredicate{

    class func predicateWithKey(key: String, value: AnyObject) -> NSPredicate{
        //TODO: Test this
        return NSPredicate(format: "%K == %@", [value])
    }
    
    class func predicateWithKeyValues(keyValuePairs: Dictionary<String, AnyObject>) -> NSPredicate{
        var predicates:[NSPredicate] = []
        for (key, value) in keyValuePairs{
            predicates.append(NSPredicate.predicateWithKey(key, value: value))
        }
        
        return NSCompoundPredicate.andPredicateWithSubpredicates(predicates)
    }
    
}


