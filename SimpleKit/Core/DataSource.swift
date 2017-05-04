//
//  DataSource.swift
//  Giggle
//
//  Created by Zac Adams on 24/08/15.
//  Copyright (c) 2015 zacattack. All rights reserved.
//

import Foundation


/**
*  Protocol for a DataSource 
*/
protocol DataSource : NSObjectProtocol{
    
    /**
    Convienience method for determining if the data source has data
    
    :returns: True if there is data, false otherwise
    */
    func hasData() -> Bool
    
    /**
    Determins the number of section contained by the data source
    
    :returns: The number of sections the data source contains
    */
    func numberOfSections() -> Int
    
    /**
    Determins the number of objects within a given section
    
    :param: section Section to query
    
    :returns: Number of objects within the specified section
    */
    func numberOfObjectsForSection(_ section: Int) -> Int
    
    /**
    Retreives the object at a given index path
    
    :param: indexPath Index path of the object to retrieve
    
    :returns: Wanted object at the specified index path, nil if the index path is invalid
    */
    func objectAtIndexPath(_ indexPath: IndexPath) -> AnyObject?
    
    /**
    Retrieves the index path of a object contained by the data source
    
    :param: object The object to get the index patho of
    
    :returns: Index path of the given object, bil if the object is not contained
    */
    func indexPathOfObject(_ object: AnyObject) -> IndexPath
}
