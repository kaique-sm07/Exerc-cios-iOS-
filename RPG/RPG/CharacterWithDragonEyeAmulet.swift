//
//  CharacterWithDragonEyeAmulet.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import Foundation

class CharacterWithDragonEyeAmulet: DecoratedCharacter {
    
    override func chanceOfSuccess() -> Int {
        return super.chanceOfSuccess() + 10
    }
   
}
