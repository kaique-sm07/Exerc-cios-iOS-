//
//  RemotePlayerWaitOpponentState.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/30/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class RemotePlayerWaitOpponentState: GameState {
    
    required init(engine:GameEngine) {
        super.init(engine: engine)
    }
    
    
    override func setUpState() {
        engine?.resetBoard()
        engine?.delegate.startGame()
    }
    
    override func play(player:TicTacToePlayer, position:TicTacToePosition)  {
        //Invalid Command
    }
    
    override func start() {
        //Start a new game
        let factory = StateFactory.getStateFactory(engine!)
        engine?.currentState = factory.createPlayerState(engine!, player: .Player1)
        //Replacing the fixed state transition
        //engine?.currentState = PlayerState(engine: engine!, player: .Player1)
    }
    
    override func finishGame() {
        if let gameEngine = engine {
            let factory = StateFactory.getStateFactory(gameEngine)
            gameEngine.currentState = factory.createEndGameState(gameEngine, victoriousItem: nil)
            //Replacing the fixed state transition
            //gameEngine.currentState = EndGameState(engine:gameEngine, victoriousItem: nil)
        }
    }
   
}
