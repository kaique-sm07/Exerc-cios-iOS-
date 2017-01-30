//
//  RemotePlayerStateFactory.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/30/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class RemotePlayerStateFactory: StateFactory {
    
    override func createWaitOpponentState(engine:GameEngine) -> GameState {
            return RemotePlayerWaitOpponentState(engine: engine)
    }
    
    override func createPlayerState(engine:GameEngine, player:TicTacToePlayer) -> GameState {
        return PlayerState(engine: engine,player: player)
    }
    
    override func createOtherPlayerState(engine:GameEngine, player:TicTacToePlayer) -> GameState {
        return RemotePlayerOtherPlayerState(engine: engine, player:player)
    }
    
    override func createEndGameState(engine:GameEngine, victoriousItem:TicTacToeItem!)  -> GameState {
       return EndGameState(engine: engine)
    }
   
}
