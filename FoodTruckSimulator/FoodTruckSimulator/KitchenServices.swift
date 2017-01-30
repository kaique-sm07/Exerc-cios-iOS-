//
//  KitchenServices.swift
//  FoodTruckSimulator
//
//  Created by SERGIO J RAFAEL ORDINE on 8/9/15.
//  Copyright (c) 2015 Sergio Ordine. All rights reserved.
//

import Foundation
import UIKit

class KitchenServices: NSObject {
    
    static func prepareOrder(type:SandwichType, ticketNumber:Int) -> Order! {
        var order:Order!
        
        //Select image URL
        var imagePath:String!
        
        switch(type){
            case .CheeseBuger:
                imagePath =  "http://www.redrobinpa.com/wp-content/uploads/2011/02/120506_WhiskeyRiverBBQBurger_hr.jpg"
            case .MistoQuente:
                imagePath = "http://www.seriouseats.com/images/2013/10/269540-papillote-croque-monsieur-top.jpg"
            default:
                imagePath = nil
        }
        
        
        if (imagePath != nil) {
            let url = NSURL(string: imagePath)
            
            if let imageURL = url {
                //Convert data to image
                let data = NSData(contentsOfURL:imageURL )
                //If conversion was ok, create the order
                if let imageData = data {
                    let baseImage = UIImage(data: imageData)
                    order = Order()
                    order.sandwichImage = baseImage
                    order.ticketNumber = ticketNumber
                }
            }
        }
        
        return order
    }

}
