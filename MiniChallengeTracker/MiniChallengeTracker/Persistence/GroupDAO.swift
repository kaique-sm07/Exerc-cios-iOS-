//
//  GroupDAO.swift
//  MiniChallengeTracker
//
//  Created by Kaique de Souza Monteiro on 25/06/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation
import CoreData

class GroupDAO{
    
    static func insertGroup(groupToBeInserted:Group){
        DatabaseManager.sharedInstance.managedObjectContext?.insertObject(groupToBeInserted)
        
        var error:NSErrorPointer = nil
        
        // save context
        DatabaseManager.sharedInstance.managedObjectContext?.save(error)
        if (error != nil)
        {
            // log error
            print(error)
        }

    }
    
    static func findByName(name:String) ->Group{
        
        let request = NSFetchRequest(entityName: "Group")

        request.predicate = NSPredicate(format: "name == %@", name)
        
        var error:NSErrorPointer = nil

        let results = DatabaseManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: error) as! [Group]
        
        return results[0]
    }
    
    
    static func deleteGroup(groupToBeDeleted:Group)
    {
        // remove object from context
        var error:NSErrorPointer = nil
        DatabaseManager.sharedInstance.managedObjectContext?.deleteObject(groupToBeDeleted)
        DatabaseManager.sharedInstance.managedObjectContext?.save(error)
        
        // log error
        if (error != nil)
        {
            // log error
            print(error)
        }
    }

}