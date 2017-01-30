//
//  TicTacToeAI.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/30/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

protocol TicTacToeAI: NSObjectProtocol {
    
    func play(board:[TicTacToeItem],playingWith:TicTacToeItem) -> TicTacToePosition
   
}
