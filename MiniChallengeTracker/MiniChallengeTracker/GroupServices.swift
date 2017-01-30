//
//  GroupServices.swift
//  MiniChallengeTracker
//
//  Created by Kaique de Souza Monteiro on 25/06/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation

class GroupServices{

    static func createGroup(name:String, people:Int, desc:String, challenge: Challenge) {
    
        var group = Group()
        group.name = name
        group.numberOfPeople = NSNumber(integer: people)
        group.projectDescription = desc
        group.challenge = challenge
        
        GroupDAO.insertGroup(group)
        
    }
    
    static func deleteGroupByName(name: String)
    {
        var auxiliarQueue:NSOperationQueue = NSOperationQueue()
        
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {

            var group:Group? = GroupDAO.findByName(name)
            if (group != nil)
            {
                // delete challenge
                GroupDAO.deleteGroup(group!)
            }
        })
        
        auxiliarQueue.addOperation(deleteOperation)
    }


}
