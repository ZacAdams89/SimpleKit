//
//  ManagedObject.swift
//  Giggle
//
//  Created by Zac Adams on 24/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation
import CoreData

//MARK:- Create in default context
extension NSManagedObject{

    class func create() -> NSManagedObject?{
        return createInContext(DefaultContext)
    }
    
    
    class func createInContext(context: NSManagedObjectContext) -> NSManagedObject?{
        return DataStore.createNewEntityForClass(self, context: context)
    }
}


//MARK:- Queries in default context
extension NSManagedObject{
    
    
    class func all() -> [NSManagedObject]?{
        return allInContext(DefaultContext)
    }
    
    
    class func allForPredicate(predicate: NSPredicate) -> [NSManagedObject]?{
        return allForPredicate(predicate, context: DefaultContext)
    }
    
    class func allForPredicate(predicate: NSPredicate, orderedBy: String, ascending: Bool) -> [NSManagedObject]?{
        return allForPredicate(predicate, orderBy: orderedBy, ascending: ascending, context: DefaultContext)
    }
    

    class func allOrderedBy(key: String, ascending: Bool) -> [NSManagedObject]?{
        return allOrderedBy(key, ascending: ascending, context: DefaultContext)
    }
    
    class func first() -> NSManagedObject?{
        return firstInContext(DefaultContext)
    }
    
    
    class func firstWithKey(key: String, value: AnyObject) -> NSManagedObject?{
        return firstWithKey(key, value: value, context: DefaultContext)
    }
 
 
    class func firstWithKeyValues(pairs: Dictionary<String, AnyObject>) -> NSManagedObject?{
        return firstWithKeyValues(pairs, context: DefaultContext)
    }
    

    class func firstWithPredicate(predicate: NSPredicate) -> NSManagedObject?{
        return firstWithPredicate(predicate, context: DefaultContext)
    }
    
    
    class func allWithKey(key: String, value: AnyObject) -> [NSManagedObject]?{
        return allWithKey(key, value: value, context: DefaultContext)
    }
   
   
    class func count() -> Int{
        return countInContext(DefaultContext)
    }
    
    class func countWithPredicate(predicate: NSPredicate) -> Int{
        return countWithPredicate(predicate, context: DefaultContext)
    }
    
    class func countWithKey(key: String, value: AnyObject) -> Int{
        return countWithKey(key, value: value, context: DefaultContext);
    }
    
}

//MARK:- Destroy in default context
extension NSManagedObject{

    class func destroyAll() {
        destroyAllInContext(DefaultContext)
    }
    
}

//MARK:- Destroy in custom context
extension NSManagedObject{
    
    class func destroyAllInContext(context: NSManagedObjectContext) {
        DataStore.removeAllEntitiesForClass(self, context:context)
    }
}

//MARK:- Query in custom context
extension NSManagedObject{
    
    class func allInContext(context: NSManagedObjectContext) -> [NSManagedObject]? {
        return DataStore.allForEntity(self, context: context)
    }
    
    class func allForPredicate(predicate: NSPredicate, context: NSManagedObjectContext) -> [NSManagedObject]? {
        return DataStore.allForEntity(self, predicate: predicate, context: context)
     
    }
    
    class func allForPredicate(predicate: NSPredicate, orderBy: String, ascending: Bool, context: NSManagedObjectContext) -> [NSManagedObject]?{
        return DataStore.allForEntity(self, predicate: predicate, orderBy: orderBy, ascending: ascending, context: context)
    }
    
    class func allOrderedBy(key: String, ascending: Bool, context:NSManagedObjectContext) -> [NSManagedObject]? {
        return DataStore.allForEntity(self, orderBy: key, ascending: ascending, context: context)
    }
    
    class func firstInContext(context: NSManagedObjectContext) -> NSManagedObject? {
      return  DataStore.entityForClass(self, context: context)
    }
    
    class func firstWithKey(key: String, value: AnyObject, context: NSManagedObjectContext) -> NSManagedObject?{
        return DataStore.entityForClass(self, predicate: NSPredicate.predicateWithKey(key, value: value) , context: context)
    }
    
    class func firstWithKeyValues(pairs: Dictionary<String, AnyObject>, context: NSManagedObjectContext) -> NSManagedObject? {
        return DataStore.entityForClass(self, predicate: NSPredicate.predicateWithKeyValues(pairs), context: context)
    }
    
    class func firstWithPredicate(predicate: NSPredicate, context: NSManagedObjectContext) -> NSManagedObject?{
        return DataStore.entityForClass(self, predicate: predicate, context: context)
    }
    
    class func allWithKey(key: String, value: AnyObject, context: NSManagedObjectContext) -> [NSManagedObject]?{
        return DataStore.allForEntity(self, predicate: NSPredicate.predicateWithKey(key, value: value), context: context)
    }
    
    class func countInContext(context: NSManagedObjectContext) -> Int{
        return DataStore.countForEntity(self, context: context)
    }
    
    class func countWithPredicate(predicate: NSPredicate, context: NSManagedObjectContext) -> Int {
        return DataStore.countForEntity(self, predicate: predicate, context: context)
    }
    
    class func countWithKey(key: String, value: AnyObject, context: NSManagedObjectContext) -> Int {
       return DataStore.countForEntity(self, predicate: NSPredicate.predicateWithKey(key, value: value), context: context)
    }
    
}

