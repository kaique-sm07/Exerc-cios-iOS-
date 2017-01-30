//
//  CommandFactory.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/29/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class CommandFactory: NSObject {
    
    
    class func createCommand (message:GameMessage, engine:GameEngine) -> GameAction! {
        

        if let startMessage = message as? StartGameMessage {
            return StartGameAction(engine: engine)
        }
        
        if let finishMessage = message as? FinishGameMessage {
            return FinishGameAction(engine: engine)
        }
        
        if let playMessage = message as? PlayMessage {
            return PlayAction(engine: engine, position: playMessage.position)
        }
        
        return nil
    }
   
}
