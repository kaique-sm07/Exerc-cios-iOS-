//
//  KitchenOperation.swift
//  FoodTruckSimulator
//
//  Created by SERGIO J RAFAEL ORDINE on 8/9/15.
//  Copyright (c) 2015 Sergio Ordine. All rights reserved.
//

import Foundation
import UIKit

class KitchenOperation: NSOperation {
    
    var order:Order!
    var callback:()->Void
    
    var sandwichType:SandwichType
    var ticketNumber:Int
    
    init(type:SandwichType, number:Int, completion:()->Void) {
        sandwichType = type
        ticketNumber = number
        callback = completion
    }
    
    override func main() {
        order = KitchenServices.prepareOrder(sandwichType, ticketNumber: ticketNumber)
        callback()
    }

}
