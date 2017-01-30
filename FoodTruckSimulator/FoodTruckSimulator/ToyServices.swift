//
//  ToyServices.swift
//  FoodTruckSimulator
//
//  Created by SERGIO J RAFAEL ORDINE on 8/9/15.
//  Copyright (c) 2015 Sergio Ordine. All rights reserved.
//

import UIKit

class ToyServices: NSOperation {
    
    static func prepareToy() -> UIImage! {
        var image:UIImage!
        
        let url = NSURL(string: "https://media.lastnightoffreedom.co.uk/images/shop/1/344/344_101_1.jpg")
        if let imageURL = url {
            
            let data = NSData(contentsOfURL:imageURL )
            if let imageData = data {
                
                let baseImage = UIImage(data: imageData)
  
                let size = baseImage!.size
                
                //Create a CGImage cloning the downloaded image
                let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
                let bitmapInfo = CGBitmapInfo(CGImageAlphaInfo.PremultipliedFirst.rawValue)
                let context = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), 8, 0, colorSpace, bitmapInfo)
                
                //Create the circular mask
                CGContextAddArc(context, CGFloat(size.width/2.0), CGFloat(size.height/2.0), 500, 0, CGFloat(2*M_PI), 0)
                CGContextClosePath(context);
                CGContextClip(context);
                
                CGContextDrawImage(context, CGRectMake(0,0,size.width, size.height), baseImage?.CGImage)
                
                let imageMasked = CGBitmapContextCreateImage(context);
                
                
                image = UIImage(CGImage: imageMasked)
                
                UIGraphicsEndImageContext();
                
            }
        }
        
        return image
    }
    
    static func assembleToy(order:Order, toyImage:UIImage!) -> Order {
        let sandwichImage = order.sandwichImage
        
        if (sandwichImage != nil && toyImage != nil) {
            UIGraphicsBeginImageContextWithOptions(sandwichImage!.size, true, 0.0);
            // Get context
            let context = UIGraphicsGetCurrentContext();
            // Push context to make it current
            // (need to do this manually because we are not drawing in a UIView)
            UIGraphicsPushContext(context);
            
            //Draw the original image
            sandwichImage!.drawInRect(CGRect(x: 0,y: 0,width: sandwichImage!.size.width, height: sandwichImage!.size.height))
            
            //Draw the toy image over the sandwich image) - 1/3rd scale
            let width = sandwichImage.size.width / 3.0
            let height = sandwichImage.size.height / 3.0
            let size = min(width, height)
            toyImage!.drawInRect(CGRect(x: 0,y: 0,width:size , height:size ))
           
            // pop context
            UIGraphicsPopContext();
            
            let  finalImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            //Recreate the order to use final image
            let finalOrder = Order()
            
            finalOrder.sandwichImage = finalImage
            finalOrder.ticketNumber = order.ticketNumber
            
            return finalOrder
            
        } else {
            return order
        }
        
    }

}
