//
//  GravatarRequest.swift
//  CarometroGravatar
//
//  Created by Kaique de Souza Monteiro on 12/08/15.
//  Copyright (c) 2015 Augusto. All rights reserved.
//

import UIKit

class GravatarRequest: NSObject {
    
    typealias FetchHandler = (String, UIImage) -> Void
    
    func fetchProfile(email: String, completionHandler: FetchHandler) {
        if let idx = find(EmailCollection.emails, email) {
        
            let hex = EmailCollection.emailsMd5Hashes[idx]
            let url = NSURL(string: "http://en.gravatar.com/\(hex).json")!
            
            let conf  = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            conf.HTTPAdditionalHeaders = ["Accept" : "application/json"]
            
            let session = NSURLSession(configuration: conf, delegate: nil, delegateQueue : nil)
            
            let dataTask = session.dataTaskWithURL(url, completionHandler: {(data, response, error) -> Void in
                
                if error == nil {
                    
                    let httpResponse = response as! NSHTTPURLResponse
                    
                    switch httpResponse.statusCode {
                        case 200:
                            self.parse(data, completionHandler: completionHandler)
                        case 404:
                            completionHandler("Profile not found", UIImage())
                        default:
                            completionHandler("http Response", UIImage())
                    }
                
                } else {
                    println(error)
                }
            
            
            
            })
            dataTask.resume()
            
        }
    }
    
    private func parse(data: NSData, completionHandler: FetchHandler) {
    
        let json = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: nil) as! Dictionary<String, [AnyObject]>
        
        let entry = json["entry"] as! [Dictionary<String, AnyObject>]
        let username = entry[0]["displayName"] as! String
        let thumbnail = entry[0]["thumbnailUrl"] as! String
        let url = NSURL(string: thumbnail)!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: nil, delegateQueue: nil)
        let dataTask = session.dataTaskWithURL(url, completionHandler: {(data, response, error) -> Void in
        
            if error == nil {
                
                let httpResponse = response as! NSHTTPURLResponse
                
                switch httpResponse.statusCode {
                case 200:
                    if let image = UIImage(data: data) {
                        completionHandler(username, image)
                    } else {
                        completionHandler(username, UIImage())
                    }
 
                default:
                    completionHandler(username, UIImage())

                }
            }
        })
        
        dataTask.resume()
    
    }
   
}
