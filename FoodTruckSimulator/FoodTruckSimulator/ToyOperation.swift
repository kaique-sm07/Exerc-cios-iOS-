//
//  ToyOperation.swift
//  FoodTruckSimulator
//
//  Created by SERGIO J RAFAEL ORDINE on 8/9/15.
//  Copyright (c) 2015 Sergio Ordine. All rights reserved.
//

import Foundation
import UIKit

class ToyOperation: NSOperation {
    
    var toyImage:UIImage!
    var callback:()->Void
    
    init(completion:()->Void) {
        callback = completion
    }
    
    override func main() {
        toyImage = ToyServices.prepareToy()
        callback()
    }
}
