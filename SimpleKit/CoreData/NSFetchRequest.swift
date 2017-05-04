//
//  FetchRequest.swift
//  Giggle
//
//  Created by Zac Adams on 24/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation
import CoreData


extension NSFetchRequest{

    
    convenience init(entityClass: AnyClass?){
        self.init(entityName: SimpleKitStringFromClass(entityClass))
    }
    
    convenience init(entityClass: AnyClass?, predicate: NSPredicate){
        self.init(entityClass: entityClass)
        self.predicate = predicate
    }
    
        
    func sortDescriptor() -> NSSortDescriptor? {
        
        if let sortDescriptors = self.sortDescriptors{
            return sortDescriptors[0] as? NSSortDescriptor;
        } else {
            return nil;
        }
    }
            
    func setSortDescriptor(_ sortDescriptor: NSSortDescriptor) {
        self.sortDescriptors = [sortDescriptor]
    }
}
