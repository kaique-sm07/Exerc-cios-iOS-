//
//  GameAction.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/29/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class GameAction: NSObject {
    
    var engine:GameEngine!
    
    init(engine:GameEngine) {
        self.engine = engine
    }
    
    
    func execute() {
        fatalError("Must Overwrite")
    }
    
}
