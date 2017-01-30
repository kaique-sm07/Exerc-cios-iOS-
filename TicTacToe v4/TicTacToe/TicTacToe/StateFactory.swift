//
//  StateFactory.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/30/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class StateFactory: NSObject {
    
    
    class func getStateFactory(engine:GameEngine) -> StateFactory {
        let factory =  (engine.gameAI != nil) ? ComputerAIPlayerStateFactory() : RemotePlayerStateFactory()
        
        return factory
    }
    
    func createWaitOpponentState(engine:GameEngine) -> GameState {
        fatalError("Must Overwrite")
    }
    
    func createPlayerState(engine:GameEngine, player:TicTacToePlayer) -> GameState {
        fatalError("Must Overwrite")
    }
    
    func createOtherPlayerState(engine:GameEngine, player:TicTacToePlayer) -> GameState {
        fatalError("Must Overwrite")
    }
    
    func createEndGameState(engine:GameEngine, victoriousItem:TicTacToeItem!) -> GameState {
        fatalError("Must Overwrite")
    }
    
    
   
}
