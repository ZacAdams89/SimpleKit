//
//  CoreDataStore.swift
//  Giggle
//
//  Created by Zac Adams on 24/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation
import CoreData

let DefaultContext = CoreDataStore.sharedInstance.defaultContext!
let DataStore = CoreDataStore.sharedInstance

protocol CoreDataStoreDelegate : class{
    func configureDataStore(dataStore: CoreDataStore, persistentStoreCoordinator: NSPersistentStoreCoordinator) -> Void
    func defaultContextForDataStore(dataStore: CoreDataStore) -> NSManagedObjectContext
}


class CoreDataStore: NSObject {
    
    
    let managedObjectModel: NSManagedObjectModel
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    var defaultContext: NSManagedObjectContext?
    var storeURL: NSURL {
        
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.zacattack.Giggle" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let url  = urls[urls.count-1] as! NSURL
        return url.URLByAppendingPathComponent("CoreDataStore.sqlite")
        
    }
    
    weak var delegate: CoreDataStoreDelegate?{
        didSet{
            delegate?.configureDataStore(self, persistentStoreCoordinator:persistentStoreCoordinator)
            defaultContext = delegate?.defaultContextForDataStore(self)
        }
    }
    
    class var sharedInstance: CoreDataStore {
        struct Static {
            static let instance: CoreDataStore = CoreDataStore()
        }
        return Static.instance
    }
    
    
    override init() {
        
        if let model = NSManagedObjectModel.mergedModelFromBundles(nil){
            managedObjectModel = model
            persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        }
        else{
            // Failed
            managedObjectModel = NSManagedObjectModel()
            persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        }
    }
}



//MARK:- Create
extension CoreDataStore{
    
    func createNewEntityForClass(entityClass: AnyClass?, context: NSManagedObjectContext) -> NSManagedObject? {
        return NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(entityClass), inManagedObjectContext: context) as? NSManagedObject;
    }
}


//MARK:- Remove
extension CoreDataStore{
    

    func removeEntity(entity: NSManagedObject, context: NSManagedObjectContext){
        context.deleteObject(entity)
    }
    
    func removeAllEntitiesForClass(entityClass: AnyClass?, context:NSManagedObjectContext) {
    
        let objects = self.allForEntity(entityClass, context: context)
        if let objects = objects{
            for object in objects {
                context.deleteObject(object)
            }
        }
    }
}


//MARK:- All
extension CoreDataStore{

    func allForEntity(entityClass: AnyClass?, context: NSManagedObjectContext) -> [NSManagedObject]?{

        let request = NSFetchRequest(entityClass: entityClass)
        return context.executeFetchRequest(request, error: nil) as? [NSManagedObject]
    }
        
    func allForEntity(entityClass: AnyClass?, predicate: NSPredicate, context: NSManagedObjectContext) -> [NSManagedObject]? {
        
        let request = NSFetchRequest(entityClass: entityClass, predicate: predicate)
        return context.executeFetchRequest(request, error: nil) as? [NSManagedObject]
        
    }
            
    func allForEntity(entityClass: AnyClass?, predicate: NSPredicate, orderBy: String, ascending: Bool, context: NSManagedObjectContext) -> [NSManagedObject]?{
        let request = NSFetchRequest(entityClass: entityClass, predicate: predicate)
        request.setSortDescriptor(NSSortDescriptor(key: orderBy, ascending: ascending))
        return context.executeFetchRequest(request, error: nil) as? [NSManagedObject]
    }
    
    func allForEntity(entityClass: AnyClass?, orderBy: String, ascending: Bool, context: NSManagedObjectContext) -> [NSManagedObject]?{
        let request = NSFetchRequest(entityClass: entityClass)
        request.setSortDescriptor(NSSortDescriptor(key: orderBy, ascending: ascending))
        return context.executeFetchRequest(request, error: nil) as? [NSManagedObject]
    }
}


//MARK:- Single
extension CoreDataStore{
    
    func entityForClass(entityClass: AnyClass?, context: NSManagedObjectContext) -> NSManagedObject?{
        let values = self.allForEntity(entityClass, context: context)
        if let values = values{
            return values.first;
        }
        
        return nil
    }
        
        
    func entityForClass(entityClass: AnyClass?, predicate: NSPredicate, context :NSManagedObjectContext) -> NSManagedObject? {
        let values = self.allForEntity(entityClass, predicate: predicate, context: context)
        if let values = values{
            return values.first;
        }
        
        return nil
    }
            
            
    func entityWithURI(uri: NSURL, context: NSManagedObjectContext) -> NSManagedObject?{
//        let objectID = self.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
//        return [self entityWithObjectID:objectID context:context];
        return nil
    }
        
    func entityWithObjectID(objectID: NSManagedObjectID?, context: NSManagedObjectContext) -> NSManagedObject? {

        if let objectID = objectID{
            return context.objectWithID(objectID)
        }
        
        return nil
    }
}


// MARK:- Count
extension CoreDataStore{
    
    func countForEntity(entityClass: AnyClass?, context: NSManagedObjectContext) -> Int {
        let request = NSFetchRequest(entityClass: entityClass)
        return context.countForFetchRequest(request, error: nil)
    }
        
    func countForEntity(entityClass: AnyClass?, predicate:NSPredicate, context: NSManagedObjectContext) -> Int {
        let request = NSFetchRequest(entityClass: entityClass, predicate: predicate)
        return context.countForFetchRequest(request, error: nil)
    }
}

