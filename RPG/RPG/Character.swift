//
//  Character.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import Foundation

class Character: NSObject {
    
    func handDamage() -> Float {
        fatalError("Must Override!")
    }
    
    func meleeDamage()->Float {
        fatalError("Must Override!")
    }
    
    func chanceOfSuccess()->Int {
        fatalError("Must Override!")
    }
   
}
