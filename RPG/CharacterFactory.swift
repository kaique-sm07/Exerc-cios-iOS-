//
//  CharacterFactory.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class CharacterFactory: NSObject {
    
    func createCharacter(item: Int) -> Character {
        return createCharacter(nil, item: item)
    }
    
    func createCharacter(baseCharacter:Character!, item:Int) -> Character {
        var character = baseCharacter != nil ? baseCharacter : Warrior()
        
        switch item {
        case 0:
            character = CharacterWithHalberd(baseCharacter: character)
        case 1:
            character = CharacterWithSword(baseCharacter: character)
        case 2:
            character = CharacterWithAxe(baseCharacter: character)
        case 3:
            character = CharacterBloodAmulet(baseCharacter: character)
        case 4:
            character = CharacterWithDragonEyeAmulet(baseCharacter: character)
        default:
            break
        }
        
        return character
    }
   
}
