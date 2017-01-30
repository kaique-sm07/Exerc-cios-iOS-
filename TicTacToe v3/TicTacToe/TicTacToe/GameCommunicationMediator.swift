//
//  GameCommunicationMediator.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/29/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

/// This class "fakes" a communication mechanism
/// in order to exemplify a message passing mechanism
/// and its converstion to commands
class GameCommunicationMediator: NSObject {
   
    var gameEngine: GameEngine
    
    init(engine:GameEngine) {
        gameEngine = engine
    }
    
    func receiveMessage(message: GameMessage) {
        let action = CommandFactory.createCommand(message, engine: gameEngine)
        
        if (action != nil) {
            action.execute()
        }
    }
}
