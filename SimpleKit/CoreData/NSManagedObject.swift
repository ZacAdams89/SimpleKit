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
    
    // Reference http://stackoverflow.com/questions/27109268/how-can-i-create-instances-of-managed-object-subclasses-in-a-nsmanagedobject-swi/27112385#27112385

    
    class func create() -> Self{
        return createInContext(DefaultContext)
    }
    
    class func createInContext(_ context: NSManagedObjectContext) -> Self{
        return createInContext(context, type: self)
    }
    
    // Helper function used to beable to cast AnyObject to self
    fileprivate class func createInContext<T>(_ context:NSManagedObjectContext, type : T.Type) -> T {
        let classname = entityName()
        let object = NSEntityDescription.insertNewObject(forEntityName: classname, into: context) as! T
        return object
    }
}


//MARK:- Queries in default context
extension NSManagedObject{
    
    
    class func all() -> [NSManagedObject]?{
        return allInContext(DefaultContext)
    }
    
    
    class func allForPredicate(_ predicate: NSPredicate) -> [NSManagedObject]?{
        return allForPredicate(predicate, context: DefaultContext)
    }
    
    class func allForPredicate(_ predicate: NSPredicate, orderedBy: String, ascending: Bool) -> [NSManagedObject]?{
        return allForPredicate(predicate, orderBy: orderedBy, ascending: ascending, context: DefaultContext)
    }
    

    class func allOrderedBy(_ key: String, ascending: Bool) -> [NSManagedObject]?{
        return allOrderedBy(key, ascending: ascending, context: DefaultContext)
    }
    
    class func first() -> NSManagedObject?{
        return firstInContext(DefaultContext)
    }
    
    
    class func firstWithKey(_ key: String, value: AnyObject) -> NSManagedObject?{
        return firstWithKey(key, value: value, context: DefaultContext)
    }
 
 
    class func firstWithKeyValues(_ pairs: Dictionary<String, AnyObject>) -> NSManagedObject?{
        return firstWithKeyValues(pairs, context: DefaultContext)
    }
    

    class func firstWithPredicate(_ predicate: NSPredicate) -> NSManagedObject?{
        return firstWithPredicate(predicate, context: DefaultContext)
    }
    
    
    class func allWithKey(_ key: String, value: AnyObject) -> [NSManagedObject]?{
        return allWithKey(key, value: value, context: DefaultContext)
    }
   
   
    class func count() -> Int{
        return countInContext(DefaultContext)
    }
    
    class func countWithPredicate(_ predicate: NSPredicate) -> Int{
        return countWithPredicate(predicate, context: DefaultContext)
    }
    
    class func countWithKey(_ key: String, value: AnyObject) -> Int{
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
    
    class func destroyAllInContext(_ context: NSManagedObjectContext) {
        DataStore.removeAllEntitiesForClass(self, context:context)
    }
}

//MARK:- Query in custom context
extension NSManagedObject{
    
    class func allInContext(_ context: NSManagedObjectContext) -> [NSManagedObject]? {
        return DataStore.allForEntity(self, context: context)
    }
    
    class func allForPredicate(_ predicate: NSPredicate, context: NSManagedObjectContext) -> [NSManagedObject]? {
        return DataStore.allForEntity(self, predicate: predicate, context: context)
     
    }
    
    class func allForPredicate(_ predicate: NSPredicate, orderBy: String, ascending: Bool, context: NSManagedObjectContext) -> [NSManagedObject]?{
        return DataStore.allForEntity(self, predicate: predicate, orderBy: orderBy, ascending: ascending, context: context)
    }
    
    class func allOrderedBy(_ key: String, ascending: Bool, context:NSManagedObjectContext) -> [NSManagedObject]? {
        return DataStore.allForEntity(self, orderBy: key, ascending: ascending, context: context)
    }
    
    class func firstInContext(_ context: NSManagedObjectContext) -> NSManagedObject? {
      return  DataStore.entityForClass(self, context: context)
    }
    
    class func firstWithKey(_ key: String, value: AnyObject, context: NSManagedObjectContext) -> NSManagedObject?{
        return DataStore.entityForClass(self, predicate: NSPredicate.predicateWithKey(key, value: value) , context: context)
    }
    
    class func firstWithKeyValues(_ pairs: Dictionary<String, AnyObject>, context: NSManagedObjectContext) -> NSManagedObject? {
        return DataStore.entityForClass(self, predicate: NSPredicate.predicateWithKeyValues(pairs), context: context)
    }
    
    class func firstWithPredicate(_ predicate: NSPredicate, context: NSManagedObjectContext) -> NSManagedObject?{
        return DataStore.entityForClass(self, predicate: predicate, context: context)
    }
    
    class func allWithKey(_ key: String, value: AnyObject, context: NSManagedObjectContext) -> [NSManagedObject]?{
        return DataStore.allForEntity(self, predicate: NSPredicate.predicateWithKey(key, value: value), context: context)
    }
    
    class func countInContext(_ context: NSManagedObjectContext) -> Int{
        return DataStore.countForEntity(self, context: context)
    }
    
    class func countWithPredicate(_ predicate: NSPredicate, context: NSManagedObjectContext) -> Int {
        return DataStore.countForEntity(self, predicate: predicate, context: context)
    }
    
    class func countWithKey(_ key: String, value: AnyObject, context: NSManagedObjectContext) -> Int {
       return DataStore.countForEntity(self, predicate: NSPredicate.predicateWithKey(key, value: value), context: context)
    }
    
}

