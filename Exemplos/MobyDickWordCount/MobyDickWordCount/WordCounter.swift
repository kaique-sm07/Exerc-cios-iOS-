//
//  WordCounter.swift
//  MobyDickWordCount
//
//  Created by Augusto Souza on 8/6/15.
//  Copyright (c) 2015 Augusto. All rights reserved.
//

import UIKit

class WordCounter {
    let path: String
    let content: String
    
    init(resourceName: String, resourceType: String) {
        self.path = NSBundle.mainBundle().pathForResource(resourceName, ofType: resourceType)!

        var error: NSError?
        let fileContents = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)!
        if error == nil {
            content = fileContents
        } else {
            content = ""
        }
    }
    
    func execute() -> [String: Int] {
        return dictForWords(content.words)
    }
    
    func executeAsync(completionHandler: ([String: Int])-> Void) {
        
        var dict = [String: Int]()
        let queue = dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
        let group = dispatch_group_create()
        let criticalLock = NSLock()
        
        dispatch_async(queue) {
        
            let words = self.content.words
            let n = words.count/100
            let chunks = self.chunkArray(words, splitSize: n)
            
            for chunk in chunks {
                dispatch_group_async(group, queue) {
                    let chunkDict = self.dictForWords(chunk)
                    for (key, value) in chunkDict {
                        criticalLock.lock()
                        if dict[key] == nil {
                            dict[key] = 0
                        }
                        dict[key] = dict[key]! + value
                        criticalLock.unlock()
                    }
                }
            }
            
            dispatch_async(queue) {
                dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
                completionHandler(dict)
            }
            
        
        }
        
    }
    
    func dictForWords(words: [String]) -> [String: Int] {
        var dict = [String: Int]()
        
        for w in words {
            if dict[w] == nil {
                dict[w] = 0
            }
            
            dict[w] =  dict[w]! + 1
        }
        
        return dict
    }
    
    private func chunkArray<T>(s: [T], splitSize: Int) -> [[T]] {
        if s.count <= splitSize {
            return [s]
        } else {
            return [Array(s[0..<splitSize])] + chunkArray(Array(s[splitSize..<s.count]), splitSize: splitSize)
        }
    }
}
