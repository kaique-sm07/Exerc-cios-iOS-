//
//  CharacterWithAxe.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import Foundation

class CharacterWithAxe: DecoratedCharacter {
    
    override func meleeDamage() -> Float {
        return super.meleeDamage() + 6.0
    }
    
    override func chanceOfSuccess() -> Int {
        return super.chanceOfSuccess() + 20
    }
   
}
