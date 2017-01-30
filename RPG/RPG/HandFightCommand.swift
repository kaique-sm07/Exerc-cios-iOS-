//
//  HandFightCommand.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class HandFightCommand: BattleCommand {
    
    var damageDone:Float = 0.0
    private var executed:Bool = false
    
    override func execute(completion:()->Void) {
        if let environment = delegate {
            
            let character =  delegate.getCharacter()
            
            if character != nil {
                
                damageDone = 0.0
                
                let dice = Int(arc4random() % 100)
    
                
                if (dice <= character.chanceOfSuccess()) {
                    damageDone = character.handDamage()
                }
                executed = true
                environment.makeDamage(Int(damageDone), completion: completion)
            }
        }
    }
    
    override func commandId() -> Int {
        return 1
    }
    
    override func undo(completion: () -> Void) {
        if  let environment = delegate {
            if executed {
                environment.healDamage(Int(damageDone), completion: completion)
            }
        }
    }
   
}
