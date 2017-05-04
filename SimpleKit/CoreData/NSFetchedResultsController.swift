//
//  NSFetchedResultsController.swift
//  Giggle
//
//  Created by Zac Adams on 31/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation
import CoreData

//MARK:- Init
extension NSFetchedResultsController {
 
//    + (instancetype)fetchedResultsControllerWithFetchRequest:(NSFetchRequest *)fetchRequest {
//    return [self fetchedResultsControllerWithFetchRequest:fetchRequest sectionKey:nil];
//    }
//    
//    + (instancetype)fetchedResultsControllerWithFetchRequest:(NSFetchRequest *)fetchRequest sectionKey:(NSString *)sectionKey {
//    return [self fetchedResultsControllerWithFetchRequest:fetchRequest sectionKey:sectionKey cacheName:nil];
//    }
//    
//    + (instancetype)fetchedResultsControllerWithFetchRequest:(NSFetchRequest *)fetchRequest sectionKey:(NSString *)sectionKey cacheName:(NSString *)cacheName {
//    return [[self alloc] initWithFetchRequest:fetchRequest managedObjectContext:DataContext sectionNameKeyPath:sectionKey cacheName:cacheName];
//    }
//    
//    - (void)performFetch {
//    [self performFetch:nil];
//    }
//    
//    - (NSUInteger)numberOfSections {
//    return self.sections.count;
//    }
//    
//    - (NSUInteger)numberOfRowsInSection:(NSInteger)section {
//    if (self.numberOfSections > section) {
//    id <NSFetchedResultsSectionInfo> sectionInfo = self.sections[section];
//    return sectionInfo.numberOfObjects;
//    }
//    
//    return 0;
//    }
//    
//    - (NSString *)nameOfSection:(NSInteger)section {
//    if (self.numberOfSections > section) {
//    id <NSFetchedResultsSectionInfo> sectionInfo = self.sections[section];
//    return sectionInfo.name;
//    }
//    
//    return nil;
//    }
//    
//    - (NSUInteger)numberOfObjects {
//    return self.fetchedObjects.count;
//    }
//    
//    - (BOOL)isEmpty {
//    return (self.numberOfObjects == 0);
//    }
    
//    convenience init(fetchRequest: NSFetchRequest<NSFetchRequestResult>){
//        self.init(fetchRequest: fetchRequest, sectionKey: nil)
//    }
//    
//    convenience init(fetchRequest: NSFetchRequest<NSFetchRequestResult>, sectionKey: String?){
//        self.init(fetchRequest: fetchRequest, sectionKey: sectionKey, cacheName: nil)
//    }
    
//    convenience init(fetchRequest: NSFetchRequest<NSFetchRequestResult>, sectionKey: String?, cacheName: String?){
//        
//        let context = DefaultContext
////        self.init(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: sectionKey, cacheName: cacheName)
//        //public init(fetchRequest: NSFetchRequest<ResultType>, managedObjectContext context: NSManagedObjectContext, sectionNameKeyPath: String?, cacheName name: String?)
//        self.init(fetchRequest: fetchRequest as! NSFetchRequest<_>, fetchRequest: context, sectionKey: sectionKey, cacheName: cacheName)
//    }
    

    func numberOfSections() -> Int{
        var sectionCount = 0
        if let sections = self.sections{
            sectionCount = sections.count
        }
        
        return sectionCount
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int{
        if let sectionInfo =  self.sections?[section]{
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func nameOfSection(_ section: Int) -> String?{
        if let sectionInfo =  self.sections?[section]{
            return sectionInfo.name
        }
        
        return nil
    }
    
//    func numberOfObjects() -> Int?{
//        return self.fetchedObjects?.count
//    }
//
//    
//    func isEmpty() -> Bool{
//        return numberOfObjects() != 0
//    }
    
}
