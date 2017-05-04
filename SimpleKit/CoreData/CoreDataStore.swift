//
//  CoreDataStore.swift
//  Giggle
//
//  Created by Zac Adams on 24/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation
import CoreData

var DefaultContext:NSManagedObjectContext{
    get{
        return CoreDataStore.sharedInstance.defaultContext!
    }
}

var DataStore:CoreDataStore{
    get{
       return CoreDataStore.sharedInstance
    }
}

protocol CoreDataStoreDelegate : class{
    func configureDataStore(_ dataStore: CoreDataStore, persistentStoreCoordinator: NSPersistentStoreCoordinator) -> Void
    func defaultContextForDataStore(_ dataStore: CoreDataStore) -> NSManagedObjectContext
}


class CoreDataStore: NSObject {
    
    
    let managedObjectModel: NSManagedObjectModel
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    var defaultContext: NSManagedObjectContext?
    var storeURL: URL {
        
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.zacattack.Giggle" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url  = urls[urls.count-1] 
        return url.appendingPathComponent("CoreDataStore.sqlite")
        
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
        
        if let model = NSManagedObjectModel.mergedModel(from: nil){
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
    
    func createNewEntityForClass(_ entityClass: AnyClass, context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: NSStringFromClass(entityClass), into: context) ;
    }
}


//MARK:- Remove
extension CoreDataStore{
    

    func removeEntity(_ entity: NSManagedObject, context: NSManagedObjectContext){
        context.delete(entity)
    }
    
    func removeAllEntitiesForClass(_ entityClass: AnyClass?, context:NSManagedObjectContext) {
    
        let objects = self.allForEntity(entityClass, context: context)
        if let objects = objects{
            for object in objects {
                context.delete(object)
            }
        }
    }
}


//MARK:- All
extension CoreDataStore{

    func allForEntity(_ entityClass: AnyClass?, context: NSManagedObjectContext) -> [NSManagedObject]?{

        let request = NSFetchRequest<NSFetchRequestResult>(entityClass: entityClass)
        return (try? context.fetch(request)) as? [NSManagedObject]
    }
        
    func allForEntity(_ entityClass: AnyClass?, predicate: NSPredicate, context: NSManagedObjectContext) -> [NSManagedObject]? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityClass: entityClass, predicate: predicate)
        return (try? context.fetch(request)) as? [NSManagedObject]
        
    }
            
    func allForEntity(_ entityClass: AnyClass?, predicate: NSPredicate, orderBy: String, ascending: Bool, context: NSManagedObjectContext) -> [NSManagedObject]?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityClass: entityClass, predicate: predicate)
        request.setSortDescriptor(NSSortDescriptor(key: orderBy, ascending: ascending))
        return (try? context.fetch(request)) as? [NSManagedObject]
    }
    
    func allForEntity(_ entityClass: AnyClass?, orderBy: String, ascending: Bool, context: NSManagedObjectContext) -> [NSManagedObject]?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityClass: entityClass)
        request.setSortDescriptor(NSSortDescriptor(key: orderBy, ascending: ascending))
        return (try? context.fetch(request)) as? [NSManagedObject]
    }
}


//MARK:- Single
extension CoreDataStore{
    
    func entityForClass(_ entityClass: AnyClass?, context: NSManagedObjectContext) -> NSManagedObject?{
        let values = self.allForEntity(entityClass, context: context)
        if let values = values{
            return values.first;
        }
        
        return nil
    }
        
        
    func entityForClass(_ entityClass: AnyClass?, predicate: NSPredicate, context :NSManagedObjectContext) -> NSManagedObject? {
        let values = self.allForEntity(entityClass, predicate: predicate, context: context)
        if let values = values{
            return values.first;
        }
        
        return nil
    }
            
            
    func entityWithURI(_ uri: URL, context: NSManagedObjectContext) -> NSManagedObject?{
//        let objectID = self.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
//        return [self entityWithObjectID:objectID context:context];
        return nil
    }
        
    func entityWithObjectID(_ objectID: NSManagedObjectID?, context: NSManagedObjectContext) -> NSManagedObject? {

        if let objectID = objectID{
            return context.object(with: objectID)
        }
        
        return nil
    }
}


// MARK:- Count
extension CoreDataStore{
    
    func countForEntity(_ entityClass: AnyClass?, context: NSManagedObjectContext) -> Int {
//        let request = NSFetchRequest(entityClass: entityClass)
        let request = NSFetchRequest<NSFetchRequestResult>(entityClass: entityClass)
        
        do{
            return try context.count(for: request)
        }
        catch(_){
            return 0;
        }
        
    }
        
    func countForEntity(_ entityClass: AnyClass?, predicate:NSPredicate, context: NSManagedObjectContext) -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityClass: entityClass, predicate: predicate)
        
        do{
            return try context.count(for: request)
        }
        catch(_){
            return 0;
        }
    }
}



//MARK:- Save
extension CoreDataStore{

    func save(){
        saveContext(self.defaultContext)
    }
    
    func saveContext(_ context:NSManagedObjectContext?){
        
        if let context = context{
            
            var error:NSError?
            if context.hasChanges {
                
                do {
                    try context.save()
                } catch let error1 as NSError {
                    error = error1
                    if let error = error{
                        NSLog("Failed to save data store context")
                    }
                }
            }
        }
    }
}

