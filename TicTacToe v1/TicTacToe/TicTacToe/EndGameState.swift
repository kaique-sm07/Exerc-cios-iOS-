//
//  EndGameState.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/28/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class EndGameState: GameState {
    
    var victorious:TicTacToeItem!
    
    required init(engine:GameEngine) {
        super.init(engine: engine)
    }
    
    convenience init(engine:GameEngine, victoriousItem:TicTacToeItem!) {
        self.init(engine: engine)
        victorious = victoriousItem
    }

    
    
    override func setUpState() {
        
        engine?.delegate?.endGame(victorious)
    }
    
    override func play(player:TicTacToePlayer, position:TicTacToePosition)  {
        //Invalid command
    }
    
    override func start() {
        //Start a new game
        engine?.resetBoard()
        engine?.delegate.startGame()
        engine?.currentState = PlayerState(engine: engine!,player:.Player1)
    }
    
   
}
