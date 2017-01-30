//
//  GameUtil.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/28/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class GameUtil: NSObject {
    
    
    ///
    /// Create the tic-tac-toe board
    ///
    class func createBoard()->[TicTacToeItem] {
        
        var board = [TicTacToeItem]()
        for (var i = 0; i < 9; i++) {
            board.append(.Empty)
        }
        
        return board
    }
    
    /// Return the index of a given position on board
    /// linearizing it.
    ///
    /// :param: position Position on board
    /// :returns: Linearized index
    class func indexOf(position:TicTacToePosition) -> Int {
        return 3 * position.y + position.x
    }
    
    
    /// Return the position on the board based 
    /// on a linearized index
    
    /// :param: index Index
    /// :returns: Position on board
    class func positionOf(index:Int) -> TicTacToePosition {
        let x = index % 3
        let y = index / 3
        
        return TicTacToePosition(x:x, y:y)
    }
    
    
    /// Return who is the other player
    ///
    /// :param: player Current player
    /// :returns: the other player
    class func otherPlayer(player:TicTacToePlayer) -> TicTacToePlayer {
        if player == .NoPlayer {
            return .NoPlayer
        } else {
            let otherPlayer:TicTacToePlayer = (player == .Player1) ? .Player2: .Player1
            return otherPlayer
        }
    }
    
    /// Return who is the other item
    ///
    /// :param: item Target item
    /// :returns: the other player
    class func otherItem(item:TicTacToeItem) -> TicTacToeItem {
        if item == .Empty {
            return .Empty
        } else {
            let otherItem:TicTacToeItem = (item == .Cross) ? .Nought: .Cross
            return otherItem
        }
    }
    
    
    // MARK: - Rule methods
    
    /// Check whether there was a victory (or draw) condition or not
    ///
    /// :param: board The game board
    /// :returns: Tuple with two parameters: the first if there was a victory (or drawn condition) and the second if Cross or Noughts won. If it was a drawn the first parameter is set to true and the second to .Empty
    class func checkVictory(board:[TicTacToeItem]) -> (victory:Bool, item:TicTacToeItem!) {
        var victory:(victory:Bool, item:TicTacToeItem!) = (false, nil)
        
        //Check rows
        victory = scanBoard(board, scanFunction: { (indexOnScannedDimension, indexOnSecondaryDimension) -> TicTacToePosition in
            return TicTacToePosition(x:indexOnSecondaryDimension,y:indexOnScannedDimension)
        })
        
        //Check columns, if needed
        if (!victory.victory) {
            victory = scanBoard(board, scanFunction: { (indexOnScannedDimension, indexOnSecondaryDimension) -> TicTacToePosition in
                return TicTacToePosition(x:indexOnScannedDimension,y:indexOnSecondaryDimension)
            })
        }
        
        //Check \ diagonal
        if (!victory.victory) {
            victory = scanDiagonal(board, scanFunction: { (index) -> TicTacToePosition in
                return TicTacToePosition(x:index,y:index)
            })
        }
        
        //Check / diagonal
        if (!victory.victory) {
            victory = scanDiagonal(board, scanFunction: { (index) -> TicTacToePosition in
                return TicTacToePosition(x:index,y:2-index)
            })
        }
        
        
        //Check draw
        if (!victory.victory) {
            var emptyPositions = false
            for (var i = 0; i < 3 ; i++) {
                for (var j = 0; j < 3 ; j++) {
                    let item = board[GameUtil.indexOf(TicTacToePosition(x:i,y:j))]
                    emptyPositions = emptyPositions || item == .Empty
                }
            }
            
            if (!emptyPositions) {
                victory = (true, TicTacToeItem.Empty)
            }
        }
    
        
        return victory
    }
    
    /// Scan the board to check if there is a sequence
    /// of three equal elements.
    ///
    /// :param: board The game board
    /// :param: scanFunction The function to get the position to be scanned 
    ///         based on the first dimension being iterated and the secondary one
    /// :returns: a Tuple with there was a set with 
    ///           ∫3 equal elements and which is that
    private class func scanBoard(board:[TicTacToeItem], scanFunction:(indexOnScannedDimension:Int,indexOnSecondaryDimension:Int)->TicTacToePosition) -> (Bool, TicTacToeItem!) {
        var victory = false
        var victorious:TicTacToeItem! = nil
        
        for (var i = 0; i < 3; i++) {
            if (!victory) {
                var currentItem:TicTacToeItem = board[GameUtil.indexOf(scanFunction(indexOnScannedDimension:i,indexOnSecondaryDimension:0))]
                for (var j = 1; j < 3; j++) {
                    let item = board[GameUtil.indexOf(scanFunction(indexOnScannedDimension:i,indexOnSecondaryDimension:j))]
                    currentItem = (currentItem == item) ? currentItem : .Empty
                }
                victory = (currentItem != .Empty)
                if victory {
                    victorious = currentItem
                }
            }
        }
        
        return (victory,victorious)
    }
    
    /// Scan the board to check if there is a sequence
    /// of three equal elements.
    ///
    /// :param: board The game board
    /// :param: scanFunction The function to get the position to be scanned based on a single index (the diagonal coordinates can be infered from just one coordinate)
    /// :returns: a Tuple with there was a set with 3 equal elements and which is that
    private class func scanDiagonal(board:[TicTacToeItem], scanFunction:(index:Int)->TicTacToePosition) -> (Bool, TicTacToeItem!) {
        var victory = false
        var victorious:TicTacToeItem! = nil
        
        var currentItem:TicTacToeItem = board[GameUtil.indexOf(scanFunction(index:0))]
        for (var i = 1; i < 3; i++) {
            let item = board[GameUtil.indexOf(scanFunction(index:i))]
            currentItem = (currentItem == item) ? currentItem : .Empty
        }
        victory = (currentItem != .Empty)
        if victory {
            victorious = currentItem
        }
        
        return (victory,victorious)
    }
   
}
