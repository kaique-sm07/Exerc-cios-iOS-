//
//  DecoratedCharacter.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import Foundation

class DecoratedCharacter: Character {
    
    private var baseCharacter: Character
    
    required init(baseCharacter:Character) {
        self.baseCharacter = baseCharacter
    }
    
    override func handDamage() -> Float {
        return baseCharacter.handDamage()
    }
   
    override func meleeDamage() -> Float {
        return baseCharacter.meleeDamage()
    }
    
    override func chanceOfSuccess() -> Int {
        return baseCharacter.chanceOfSuccess()
    }
    
}
