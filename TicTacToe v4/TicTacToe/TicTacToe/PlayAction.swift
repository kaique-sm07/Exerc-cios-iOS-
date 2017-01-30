//
//  PlayAction.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/29/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class PlayAction: GameAction {
    
    var position:TicTacToePosition
    
    required init(engine:GameEngine, position:TicTacToePosition) {
        self.position = position
        super.init(engine: engine)
    }
    
    override func execute() {
        engine.play(.Player2, position:self.position)
    }
   
}
