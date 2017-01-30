//
//  BaseCommand.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

protocol BattleProtocol:NSObjectProtocol {
    
    func makeDamage(healthPoints:Int, completion:()->Void)
    func healDamage(healthPoints:Int, completion:()->Void)
    func pass(completion:()->Void)
    func getCharacter()->Character!
    
}

class BattleCommand: NSObject {
    
    
    weak var delegate:BattleProtocol!
    
    func commandId() -> Int {
        fatalError("Must Override!")
    }
    
    func execute(completion:()->Void) {
        fatalError("Must Override!")
    }
    
    func undo(completion:()->Void) {
        fatalError("Must Override!")
    }
   
}
