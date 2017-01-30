//
//  TicTacToePosition.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/28/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import Foundation

struct TicTacToePosition {
    var x:Int
    var y:Int
}

enum TicTacToeItem {
    case Empty
    case Nought
    case Cross
}

enum TicTacToePlayer:Int {
    case NoPlayer = 0
    case Player1 = 1
    case Player2 = 2
}