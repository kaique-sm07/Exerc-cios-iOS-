//
//  InstagramRequest.swift
//  Mural
//
//  Created by Kaique de Souza Monteiro on 13/08/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit

class InstagramRequest: NSObject {
    
   

    static func getPhotos(callback: ([UIImage]) -> Void) {
        let criticalLock = NSLock()
        let baseURLString = "https://api.instagram.com/v1/users/"
        let accessToken = "2069137519.5b9e1e6.fe755f8a346b4811bb3de8a49bdeba1a"
        let userId = "259220806"
        
        
        
        
        let url = NSURL(string: baseURLString+userId+"/media/recent/?access_token="+accessToken)
        
        let config  = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        config.HTTPAdditionalHeaders = ["Accept" : "application/json"]
        
        let session = NSURLSession(configuration: config, delegate: nil, delegateQueue : nil)
        
        let dataTask = session.dataTaskWithURL(url!, completionHandler: {(data, response, error) -> Void in
            
            if error == nil {
                
                let httpResponse = response as! NSHTTPURLResponse
                
                switch httpResponse.statusCode {
                case 200:
                    self.parse(data, callback: callback)
                    break
                default:
                    callback([UIImage()])
                }
                
            } else {
                println(error)
            }
            
            
            
        })
        dataTask.resume()
        
        
    }
    
    private static func parse(data: NSData, callback: ([UIImage]) -> Void) {
        
        
        let json = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: nil) as! Dictionary<String, AnyObject>

        
        let jsonData = json["data"] as! [Dictionary<String, AnyObject>]
        
        println("\(jsonData)")

        var imagesArray = [UIImage]()
        var criticalRegion = NSLock()
        
        
        for i in 0..<jsonData.count {
            let images = jsonData[i]["images"] as! Dictionary<String, AnyObject>
 
            
            let imageStandardResolution = images["standard_resolution"] as! Dictionary<String, AnyObject>

            
            let imageUrl = imageStandardResolution["url"] as! String
            
            let url = NSURL(string: imageUrl)!
            

            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
            let dataTask = session.dataTaskWithURL(url, completionHandler: {(data, response, error) -> Void in
                if error == nil {
                    criticalRegion.lock()
                    let httpResponse = response as! NSHTTPURLResponse
                    
                    switch httpResponse.statusCode {
                    case 200:
                        
                        if let image = UIImage(data: data) {
                            imagesArray.append(image)
                        } else {
                           imagesArray.append(UIImage())
                        }
                        
                    default:
                        imagesArray.append(UIImage())
                        
                    }
                } else  {
                    imagesArray.append(UIImage())
                }
                println("Array count is \(imagesArray.count) \(jsonData.count)")
                criticalRegion.unlock()
                
                
                criticalRegion.lock()
                let processHasFinished = imagesArray.count == jsonData.count
                criticalRegion.unlock()
                if processHasFinished {
                    callback(imagesArray)
                }

            })
            
            dataTask.resume()

        }
        
    }



}

