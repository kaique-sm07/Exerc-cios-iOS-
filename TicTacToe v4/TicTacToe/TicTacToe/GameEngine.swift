//
//  GameEngine.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/28/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import Foundation




protocol GameEngineDelegate:NSObjectProtocol {
    
    /// Set the item on a position of the board
    ///
    /// :param: position Position on board
    /// :param: item Item to be set on that position
    func setPosition(position:TicTacToePosition, item:TicTacToeItem)
    
    /// Adjust the interface for a given player
    ///
    /// :param: player Current player
    func adjustInterface(player:TicTacToePlayer)
    
    /// Adjust the interface for the end of game
    ///
    /// :param: victoriousItem The kind of item that won, .Empty if it was a draw
    func endGame(victoriousItem:TicTacToeItem!)
    
    /// Adjust the interface for starting a game
    func startGame()
}


class GameEngine: NSObject {
    
    private var kvoContext: UInt8 = 1
    
    // Dynamic keyword allows this attribute to be observable by a
    // key value observer (KVO). 
    // Apply this modifier to any member of a class that can be represented by Objective-C.
    // When you mark a member declaration with the dynamic modifier, access to that member is
    // always dynamically dispatched using the Objective-C runtime. Access to that member is never 
    // inlined or devirtualized by the compiler.
    
    dynamic var currentState:GameState!
    private var board:[TicTacToeItem]
    var gameAI: TicTacToeAI!
    
    weak var delegate:GameEngineDelegate!

    
    var firstPlayerType:TicTacToeItem!
    var secondPlayerType:TicTacToeItem!
    
    override init() {
        //Setup
        board = GameUtil.createBoard()
        super.init()
        
       
        
        let options = NSKeyValueObservingOptions.New | NSKeyValueObservingOptions.Old | NSKeyValueObservingOptions.Initial

        self.addObserver(self, forKeyPath: "currentState",
            options: NSKeyValueObservingOptions.New, context: &kvoContext)
        
        //First state
        let factory = StateFactory.getStateFactory(self)
        currentState = factory.createWaitOpponentState(self)
        //Replacing the fixed state transition
        //currentState = WaitOpponentState(engine: self)
        
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "currentState")
    }
    
    
    func getBoard()->[TicTacToeItem] {
        return board
    }

    
    func play(player:TicTacToePlayer, position:TicTacToePosition)  {
        currentState.play(player,position:position)
    }
    
    func start() {
        return currentState.start()
    }
    
    func endGame() {
        return currentState.finishGame()
    }
     
    func resetBoard() {
        board = GameUtil.createBoard()
    }
    
   
    // MARK: - Board Methods
    
    /// Fill one board cell with a given item
    ///
    /// :param: position The cell position
    /// :item: item Item to be inserted on the given cell
    func setPos(player:TicTacToePlayer, position:TicTacToePosition) -> Bool {
    
        
        let value = self.getPos(position)
        
        let isValidPosition = (value == TicTacToeItem.Empty)
        
        
        if isValidPosition {
            let item = player == .Player1 ? self.firstPlayerType : self.secondPlayerType
            
            let index = GameUtil.indexOf(position)
            if (index >= 0 && index < 9) {
                board[index] = item
                if delegate != nil {
                    delegate.setPosition(position, item:item)
                }
            }
        }
        
        
        return isValidPosition
    }
    
    /// Get the item on a given board position
    ///
    /// :param: position Target position
    /// :returns: Which item is presented on that position
    func getPos(position:TicTacToePosition) -> TicTacToeItem! {
       return board[GameUtil.indexOf(position)]
    }
    
    // MARK: - Rules
    /// Check if there was a vicotry condition on the game
    func checkVictory() -> (victory:Bool, item:TicTacToeItem!) {
        return GameUtil.checkVictory(board)
    }

    
    // MARK: - KVO
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject: AnyObject], context: UnsafeMutablePointer<Void>) {
        if context == &kvoContext {
            if keyPath == "currentState" {
                currentState.setUpState()
            }
        }
    }
}
