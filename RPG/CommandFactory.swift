//
//  CommandFactory.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class CommandFactory: NSObject {
    
    func createCommand(commandId:Int) -> BattleCommand {
        
        var command:BattleCommand = DoNothingCommand()
        
        switch commandId {
            case 1:
                command = HandFightCommand()
            case 2:
                command = MeleeFightCommand()
            case 3:
                command = DoNothingCommand()
            default:
                break
        }
        
        return command
        
    }
   
}
