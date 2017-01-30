//
//  Warrior.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import Foundation

class Warrior: Character {
    
    override func handDamage() -> Float {
        return 2.0
    }
    
    override func meleeDamage() -> Float {
        return 2.0
    }
    
    override func chanceOfSuccess() -> Int {
        return 40
    }
   
}
