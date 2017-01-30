//
//  ChallengeServices.swift
//  MiniChallengeTracker
//
//  Created by Fernando Celarino on 6/23/15.
//  Copyright (c) 2015 Fernando Celarino. All rights reserved.
//

import Foundation

class ChallengeServices
{
    static func createChallenge(name:String, duration:NSInteger, startDate:NSDate, endDate: NSDate)
    {
        var challenge:Challenge = Challenge()
        challenge.name = name
        challenge.duration = duration
        challenge.startDate = startDate
        challenge.endDate = endDate
        
        // insert it
        ChallengeDAO.insert(challenge)

    }
    
    static func deleteChallegeByName(name: String)
    {
        // create queue
        var auxiliarQueue:NSOperationQueue = NSOperationQueue()
        
        // create operation
        let deleteOperation : NSBlockOperation = NSBlockOperation(block: {
            // find challenge
            var challenge:Challenge? = ChallengeDAO.findByName(name)
            if (challenge != nil)
            {
                // delete challenge
                ChallengeDAO.delete(challenge!)
            }
        })
        
        // execute operation
        auxiliarQueue.addOperation(deleteOperation)
    }
    
    static func isEmpty() ->Bool{
        return ChallengeDAO.findAll().isEmpty
    }
    
    static func searchByName(name:String) -> Challenge {
    
        return ChallengeDAO.findByName(name)!
    
    }
    
}