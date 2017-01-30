//
//  UIColor+RPGColors.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func notEnabledColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    class func handFightColor() -> UIColor {
        //Color #D36019
        return UIColor(red: 0xD3/0xFF, green: 0x60/0xFF, blue: 0x19/0xFF, alpha: 1.0)
    }
    
    class func meleeFightColor() -> UIColor {
        //Color #A93012
        return UIColor(red: 0xA9/0xFF, green: 0x30/0xFF, blue: 0x12/0xFF, alpha: 1.0)
    }
    
    class func noActionColor() -> UIColor {
        //Color #6C7AD1
        return UIColor(red: 0x6C/0xFF, green: 0x7A/0xFF, blue: 0xD1/0xFF, alpha: 1.0)
    }
    
    class func executingActionColor() -> UIColor {
        return UIColor.blueColor()
    }
    
    class func executedActionColor() -> UIColor {
        return UIColor(red: 0xA9/0xFF, green: 0x30/0xFF, blue: 0x12/0xFF, alpha: 1.0)
    }
    
    class func executingUndoColor() -> UIColor {
        return UIColor.blueColor()
    }
    
}
