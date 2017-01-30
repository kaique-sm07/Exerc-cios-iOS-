//
//  PlayerState.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/28/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class PlayerState: GameState {
    
    var playerPos:TicTacToePlayer!
    
    required init(engine:GameEngine) {
        super.init(engine: engine)
    }
    
    convenience init(engine:GameEngine, player:TicTacToePlayer) {
        self.init(engine: engine)
        self.playerPos = player
    }
    
    
    override func setUpState() {
        engine?.delegate?.adjustInterface(playerPos)
    }
    
    override func play(player:TicTacToePlayer, position:TicTacToePosition)  {
        if let engine = self.engine {
            
            let isValidPlayer = (playerPos == player)
            
            if isValidPlayer {
                let isValidPlay = engine.setPos(player,position:position)
                
                //Check victory or end game
                let result = engine.checkVictory()
                if (result.victory) {
                    engine.currentState = EndGameState(engine: engine, victoriousItem: result.item)
                } else {
                    engine.currentState = OtherPlayerState(engine: engine,player:GameUtil.otherPlayer(playerPos))
                }
            }
        }
    }
    
    override func start() {
        //Invalid command
    }
    
   
}
