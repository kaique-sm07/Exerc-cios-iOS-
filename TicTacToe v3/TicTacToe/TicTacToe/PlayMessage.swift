//
//  PlayMessage.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/29/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class PlayMessage: GameMessage {
    
    var position:TicTacToePosition
    
    required init(position:TicTacToePosition) {
        self.position = position
    }
   
}
