//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/28/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController, GameEngineDelegate {

    @IBOutlet weak var board: TicTacToeView!
    
    @IBOutlet var firstPlayerButtons: [UIButton]!
    @IBOutlet var secondPlayerButtons: [UIButton]!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    
    
    private var engine:GameEngine = GameEngine()
    private var mediator:GameCommunicationMediator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        engine.gameAI = RandomPlayAI()
        engine.delegate = self
        mediator = GameCommunicationMediator(engine: self.engine)

        
        
        engine.firstPlayerType = .Cross
        engine.secondPlayerType = .Nought
        
        engine.start()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - GameEngineDelegate methods
    
    /// Set the item on a position of the board
    ///
    /// :param: position Position on board
    /// :param: item Item to be set on that position
    func setPosition(position:TicTacToePosition, item:TicTacToeItem) {
        board.setPos(position, item: item)
    }
    
    /// Adjust the interface for a given player
    ///
    /// :param: player Current player
    func adjustInterface(player:TicTacToePlayer) {
        
        
        let buttonList = (player == .Player1) ? firstPlayerButtons: secondPlayerButtons
        let otherButtonList = (player == .Player1) ? secondPlayerButtons: firstPlayerButtons
        
        //Enable valid buttons
        if (player == .Player1 || engine.gameAI == nil) {
            for button in buttonList {
                button.enabled = engine.getPos(GameUtil.positionOf(button.tag))! == .Empty
            }
        }
        
        //Disable other set of buttons
        for button in otherButtonList {
            button.enabled = false
        }
        
        playButton.enabled = false
        disconnectButton.enabled = (engine.gameAI == nil)
        
    }
    
    /// Adjust the interface for the end of game
    ///
    /// :param: victoriousItem The kind of item that won, .Empty if it was a draw
    func endGame(victoriousItem: TicTacToeItem!) {
        
        //Disable all buttons
        for button in firstPlayerButtons {
            button.enabled = false
        }
        for button in secondPlayerButtons {
            button.enabled = false
        }
        
        var message:String
        if let item = victoriousItem {
            switch item {
            case .Cross:
                message = "X venceu!"
            case .Nought:
                message = "O venceu!"
            case .Empty:
                message = "Deu velha!"
            }
        } else {
            message = "Jogo terminado!"
        }
        
        
        
        let alertController = UIAlertController(title: "Fim", message: message, preferredStyle: .Alert)
        
        let restartActionMultiplayer = UIAlertAction(title: "Novo Jogo - Multiplayer", style: .Default) { (action) -> Void in
            self.engine.gameAI = nil
            self.engine.start()
        }
        
        let restartActionEasy = UIAlertAction(title: "Novo Jogo - Easy", style: .Default) { (action) -> Void in
            self.engine.gameAI = RandomPlayAI()
            self.engine.start()
        }
        
        let restartActionHard = UIAlertAction(title: "Novo Jogo - Hard", style: .Default) { (action) -> Void in
            self.engine.gameAI = MinMaxAI()
            self.engine.start()
        }
        
        alertController.addAction(restartActionMultiplayer)
        alertController.addAction(restartActionEasy)
        alertController.addAction(restartActionHard)
        
        self.presentViewController(alertController, animated: true) { () -> Void in

        }
        
        playButton.enabled = false
        disconnectButton.enabled = false
        
    }
    
    /// Adjust the interface for starting a game
    func startGame() {
        board.clearBoard()
        
        if (engine.gameAI == nil) {
        
            for button in firstPlayerButtons {
                button.enabled = false
            }
            for button in secondPlayerButtons {
                button.enabled = false
            }
            
            playButton.enabled = true
            disconnectButton.enabled = false
        } else {
            for button in firstPlayerButtons {
                button.enabled = true
            }
            playButton.enabled = (engine.gameAI == nil)
            disconnectButton.enabled = false
        }
    }
    
    // MARK: - Gesture Recognizer action methods
    
    @IBAction func startGame(sender: UIButton) {
        mediator.receiveMessage(StartGameMessage())
    }
    
    @IBAction func disconnectGame(sender: UIButton) {
        mediator.receiveMessage(FinishGameMessage())
    }
    
    // MARK: - Action methods
    
    // Player 1 buttons action
    @IBAction func playAsPlayer1(sender: UIButton) {
        engine.play(.Player1, position: GameUtil.positionOf(sender.tag))
    }
    
    // Player 2 buttons action
    @IBAction func playAsPlayer2(sender:UIButton) {
        mediator.receiveMessage(PlayMessage(position:  GameUtil.positionOf(sender.tag)))
    }


}
