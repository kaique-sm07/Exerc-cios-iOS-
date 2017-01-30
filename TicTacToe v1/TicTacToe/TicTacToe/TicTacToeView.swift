//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by SERGIO J RAFAEL ORDINE on 5/28/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit



/// A View that draw a tic-tac-toe board
@IBDesignable
class TicTacToeView: UIView {
    
    /// Padding to draw the item within a cell
    var itemBorder:CGFloat = 15.0
    
    /// The game board
    private var board:[TicTacToeItem]!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clearBoard()
    }
    
    /// Clear the game board
    func clearBoard() {
        board = GameUtil.createBoard()
        
        setNeedsDisplay()
        
    }
    
    /// Fill one board cell with a given item
    ///
    /// :param: position The cell position
    /// :item: item Item to be inserted on the given cell
    func setPos(position:TicTacToePosition, item:TicTacToeItem) {
        if board != nil {
            let position = GameUtil.indexOf(position)
            if (position >= 0 && position < 9) {
                board[position] = item
                setNeedsDisplay()
            }
        }
    }
    
    /// Get the item present on a given board cell
    ///
    /// :param: position The cell position
    /// :returns: Item on that position, .Empty if none
    func getPos(position:TicTacToePosition) -> TicTacToeItem! {
        if board != nil {
            return board[GameUtil.indexOf(position)]
        } else {
            return nil
        }
    }
    
    
    

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext();
        let boardLineWidth:CGFloat = 3.0;
        let splitX = frame.size.width / 3
        let splitY = frame.size.height / 3

        
        CGContextSaveGState(context);
        CGContextSetLineCap(context, kCGLineCapSquare);
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor); //change color here
        CGContextSetLineWidth(context, boardLineWidth);
        
        
        for (var i = 1; i < 3; i++) {
            
            let posX = splitX * CGFloat(i)
            let posY = splitY * CGFloat(i)
            
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, posX , 0);
            CGContextAddLineToPoint(context, posX, frame.size.height);
            CGContextStrokePath(context);
            CGContextRestoreGState(context);
            
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, 0 , posY);
            CGContextAddLineToPoint(context, frame.size.width, posY);
            CGContextStrokePath(context);
            CGContextRestoreGState(context);
        }
        
        
        
        if let boardData = board {
            
            for (var i = 0; i < 3; i++) {
                for (var j = 0; j < 3 ; j++) {
                    
                    let position = TicTacToePosition(x:i, y:j)
                    
                    let posX = splitX * CGFloat(i) + itemBorder
                    let posY = splitY * CGFloat(j) + itemBorder
                    drawItem(getPos(position),bounds: CGRect(x: posX,y: posY,
                        width: splitX - 2 * itemBorder, height: splitY - 2 * itemBorder))
                }
            }
        }

    }
    
    /// Draw an item on a cell
    /// 
    /// :param: item Item to be drawn
    /// :param: bounds The bounds to draw the item
    private func drawItem(item:TicTacToeItem!, bounds:CGRect) {
        
        if let validItem = item {
        
        
            let context = UIGraphicsGetCurrentContext();
            let itemLineWidth:CGFloat = 3.0;
            
                switch validItem {
                    case .Cross:
                        CGContextSaveGState(context);
                        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
                        CGContextSetLineWidth(context, itemLineWidth)
                        CGContextMoveToPoint(context, bounds.origin.x , bounds.origin.y)
                        CGContextAddLineToPoint(context, bounds.origin.x + bounds.width, bounds.origin.y + bounds.height)
                        CGContextStrokePath(context)
                        CGContextRestoreGState(context)
                        CGContextSaveGState(context)
                        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
                        CGContextSetLineWidth(context, itemLineWidth)
                        CGContextMoveToPoint(context, bounds.origin.x + bounds.width , bounds.origin.y);
                        CGContextAddLineToPoint(context, bounds.origin.x, bounds.origin.y + bounds.height)
                        CGContextStrokePath(context)
                        CGContextRestoreGState(context)
                    case .Nought:
                        CGContextSaveGState(context);
                        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
                        CGContextSetLineWidth(context, itemLineWidth)
                        CGContextMoveToPoint(context, bounds.origin.x , bounds.origin.y)
                        CGContextStrokeEllipseInRect(context, bounds)
                        CGContextStrokePath(context)
                        CGContextRestoreGState(context)
                    case .Empty:
                        break;
                }
        }
        
    }
    

}
