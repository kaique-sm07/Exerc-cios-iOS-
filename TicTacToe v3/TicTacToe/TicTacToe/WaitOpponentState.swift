//
//  StartState.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/29/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class WaitOpponentState: GameState {
    
    
    required init(engine:GameEngine) {
        super.init(engine: engine)
    }
    
    
    override func setUpState() {
        engine?.resetBoard()
        engine?.delegate.startGame()
        start()
    }
    
    override func play(player:TicTacToePlayer, position:TicTacToePosition)  {
        //Invalid Command
    }
    
    override func start() {
        engine?.currentState = PlayerState(engine: engine!, player: .Player1)
    }
    
    override func finishGame() {
        if let gameEngine = engine {
            gameEngine.currentState = EndGameState(engine:gameEngine, victoriousItem: nil)
        }
    }
   
}
