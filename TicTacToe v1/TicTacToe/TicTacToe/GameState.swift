//
//  GameState.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/28/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class GameState: NSObject {
    
    //Keeps a reference to the state context
    /// The game engine (State machine context)
    weak var engine:GameEngine?
    
    required init(engine:GameEngine) {
        super.init()
        self.engine = engine
    }
    
    ///Setup this state, it makes
    ///all the actions needed when entering the state
    func setUpState() {
        fatalError("Must Overwrite!")
    }
    
    /// A player turn.
    ///
    /// :param: player Player that is trying to play
    /// :param: position Position where the player is trying to play
    func play(player:TicTacToePlayer, position:TicTacToePosition)  {
        fatalError("Must Overwrite!")
    }
    
    /// Starts a tic-tac-toe game
    func start() {
        fatalError("Must Overwrite!")
    }

   
}
