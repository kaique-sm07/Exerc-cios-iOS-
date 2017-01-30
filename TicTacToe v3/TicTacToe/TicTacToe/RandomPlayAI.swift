//
//  RandomPlayAI.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/30/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class RandomPlayAI: NSObject, TicTacToeAI {
    
    func play(board:[TicTacToeItem],playingWith:TicTacToeItem) -> TicTacToePosition {
        
        var emptyPositions = [Int]()
        
        for (var i = 0; i < 3; i++) {
            for (var j = 0; j < 3 ; j++) {
                let index = GameUtil.indexOf(TicTacToePosition(x:i,y:j))
                
                if (board[index] == TicTacToeItem.Empty) {
                    emptyPositions.append(index)
                }
            }
        }
        
        let selectedPosition = Int(arc4random()) % emptyPositions.count
        
        return GameUtil.positionOf(emptyPositions[selectedPosition])
        
    }
   
}
