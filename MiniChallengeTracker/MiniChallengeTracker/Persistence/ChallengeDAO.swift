//
//  ChallengeDAO.swift
//  MiniChallengeTracker
//
//  Created by Fernando Celarino on 6/23/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation
import CoreData

class ChallengeDAO
{
    static func findByNameAndDuration(name: String, duration: NSInteger) -> [Challenge]
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Challenge")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@ AND duration >= %ld", name, duration)
        
        // assign sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending:true)]
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Challenge] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Challenge]
        
        return results
    }
    
    static func findByName(name: String) -> Challenge?
    {
        // creating fetch request
        let request = NSFetchRequest(entityName: "Challenge")
        
        // assign predicate
        request.predicate = NSPredicate(format: "name == %@", name)
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Challenge] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Challenge]
        
        return results[0]
    }

    
    static func insert(objectToBeInserted:Challenge)
    {
        // insert element into context
        DatabaseManager.sharedInstance.managedObjectContext?.insertObject(objectToBeInserted)
        
        // save context
        var error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.save(error)
        if (error != nil)
        {
            // log error
            print(error)
        }
    }

    static func delete(objectToBeDeleted:Challenge)
    {
        // remove object from context
        var error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.deleteObject(objectToBeDeleted)
        DatabaseManager.sharedInstance.managedObjectContext?.save(error)
        
        // log error
        if (error != nil)
        {
            // log error
            print(error)
        }
    }
    
    static func findAll() -> [Challenge] {
    
        let request = NSFetchRequest(entityName: "Challenge")
        
        // perform search
        var error:NSErrorPointer = nil
        let results:[Challenge] = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Challenge]
        
        return results

    }

    

}