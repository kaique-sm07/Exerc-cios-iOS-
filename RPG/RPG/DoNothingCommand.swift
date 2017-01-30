//
//  DoNothingCommand.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class DoNothingCommand: BattleCommand {
    
    private var executed:Bool = false
    
    override func execute(completion:()->Void) {
        //Do nothing!
        if let environment = delegate {
            executed=true
            delegate.pass(completion)
        }
    }
    
    override func commandId() -> Int {
        return 3
    }
    
    override func undo(completion: () -> Void) {
        if  let environment = delegate {
            if executed {
                environment.pass(completion)
            }
        }
    }
   
}
