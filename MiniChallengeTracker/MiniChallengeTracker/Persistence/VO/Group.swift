//
//  Group.swift
//  MiniChallengeTracker
//
//  Created by Fernando Celarino on 6/23/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation
import CoreData

class Group: NSManagedObject
{

    @NSManaged var name: String
    @NSManaged var numberOfPeople: NSNumber
    @NSManaged var projectDescription: String
    @NSManaged var challenge: Challenge

}
