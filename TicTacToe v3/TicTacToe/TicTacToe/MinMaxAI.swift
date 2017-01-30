//
//  MinMaxAI.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/30/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit


class MinMaxAI: NSObject,TicTacToeAI {
    
    struct Move {
        var score: Int
        var position:TicTacToePosition
    }
    
    let VICTORY_SCORE = 10
    
    func play(board:[TicTacToeItem],playingWith:TicTacToeItem) -> TicTacToePosition {
        return minmax(board, playingWith: playingWith, currentTurn: playingWith).position
    }
    
    
    ///Check the best movement for a given turn, considering the
    /// max score if the player is moving and the worst one, in case
    ///it is an opponent turn.
    ///
    /// :param: board The target board
    /// :param: playingWith The item the player is using
    /// :param: currentTurn The item that is current being played
    private func minmax(board:[TicTacToeItem],playingWith:TicTacToeItem, currentTurn:TicTacToeItem) -> Move {
        
        var selectedMove:Int!
        var selectedScore:Int!
        
        var evaluatedMoves = [Move]()
        
        //Get list of possible movements from current board
        let moves = possibleMoves(board)
        //For each possibility 

        for move in moves {
            //Creates this virtual board
            var newBoard = board
            newBoard[move] = currentTurn
            //Check score for that board (from the AI's perspective)
            let victoryCondition = GameUtil.checkVictory(newBoard)
            if (victoryCondition.victory) {
                let newScore = score(newBoard, playingWith: playingWith)
                evaluatedMoves.append(Move(score: newScore,position: GameUtil.positionOf(move)))
            } else {
                //Recursivelly checks score if it is not an end position
                let newScore = minmax(newBoard, playingWith: playingWith, currentTurn: GameUtil.otherItem(currentTurn))
                evaluatedMoves.append(Move(score: newScore.score,position: GameUtil.positionOf(move)))
            }
        }
        
        //Select proper move, maximizing score on the AI player turn and
        //and minimizing on the opponent one (as the best movement for the
        //opponent is to defeat you, what means, your worst score)
        
        //The reduce function "converts" the array into a single summarized value 
        //according to the reduce function given. In the following case we
        //are using a function to maximize or minimize the value of the array.
        let computedMove:Move = (currentTurn == playingWith) ? evaluatedMoves.reduce(evaluatedMoves[0]) { return ($0.score > $1.score) ? $0: $1 } :
            evaluatedMoves.reduce(evaluatedMoves[0]) { return ($0.score > $1.score) ? $1: $0 }

        return computedMove
        
    }
    

    // MARK: - Auxiliary methods
    
    /// Check possible moves on a given board
    ///
    /// :param: board Game board to be evaluated
    /// :returns list of index for the possible moves
    func possibleMoves(board:[TicTacToeItem]) -> [Int] {
        var moves = [Int]()
        for (var i = 0; i < 9; i++) {
            if (board[i] == TicTacToeItem.Empty) {
                moves.append(i)
            }
        }
        return moves
    }
    
    /// Checks the score of a given board.
    ///
    /// :param: board The current game board
    /// :param: playingWith Which kind of item the AI is playing with
    ///
    /// :returns: The score of the current board, from the AI player perspective.
    private func score(board:[TicTacToeItem], playingWith:TicTacToeItem) -> Int {
        let victoryCondition = GameUtil.checkVictory(board)
        
        let depth = currentDepth(board)
        
        // It will get 10 for a victory, -10 for a loose and 0 for a draw or in-game move
        // But in order to avoid a "fatalist" approach (it does not matter if I loose now or
        // in a few moves, so I make a bad move to finish it quicky) the depth (number of plays)
        // is also used for that.
        if (victoryCondition.victory) {
            //Player victory
            if (victoryCondition.item == playingWith) {
                return VICTORY_SCORE - depth
            } else {
                if (victoryCondition.item != .Empty) {
                    //Opponent victory
                    return depth - VICTORY_SCORE
                } else {
                    return 0
                }
            }
        } else {
            return 0
        }
    }
    
    
    /// Get the current game depth (number of moves already made)
    ///
    /// :param: board Game board being evaluated
    /// :returns: Depth (number of moves) of this board
    private func currentDepth(board:[TicTacToeItem]) -> Int {
        var numberOfMoves = 0
        
        for (var i = 0; i < 9; i++) {
            if board[i] != .Empty {
                numberOfMoves++
            }
        }
        
        return numberOfMoves
    }
}
