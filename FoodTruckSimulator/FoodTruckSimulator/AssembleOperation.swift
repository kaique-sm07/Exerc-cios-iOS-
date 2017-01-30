//
//  AssembleOperation.swift
//  FoodTruckSimulator
//
//  Created by SERGIO J RAFAEL ORDINE on 8/9/15.
//  Copyright (c) 2015 Sergio Ordine. All rights reserved.
//

import UIKit

class AssembleOperation: NSOperation {
    
    var callback : (Order!)->Void
    
    init(completion:(Order!)->Void) {
        callback = completion
    }

    override func main() {
        var originalOrder:Order!
        var toyImage:UIImage!
        
        for dependency in dependencies {
            var kitchenOperation = dependency as? KitchenOperation
            if kitchenOperation != nil {
                originalOrder = kitchenOperation?.order
            }
            
            var toyOperation = dependency as? ToyOperation
            if toyOperation != nil {
                toyImage = toyOperation?.toyImage
            }
            
            
        }
        let finalOrder = ToyServices.assembleToy(originalOrder, toyImage: toyImage)
        
        callback(finalOrder)
    }
}
