//
//  Challenge.swift
//  MiniChallengeTracker
//
//  Created by Fernando Celarino on 6/22/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation
import CoreData

class Challenge: NSManagedObject
{
    @NSManaged var name: String
    @NSManaged var duration: NSInteger
    @NSManaged var startDate: NSDate
    @NSManaged var endDate: NSDate
    @NSManaged var groupList: NSSet
    
    /// The designated initializer
    convenience init()
    {
        // get context
        let context:NSManagedObjectContext = DatabaseManager.sharedInstance.managedObjectContext!
        
        // create entity description
        let entityDescription:NSEntityDescription? = NSEntityDescription.entityForName("Challenge", inManagedObjectContext: context)
        
        // call super using
        self.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
    }

}
