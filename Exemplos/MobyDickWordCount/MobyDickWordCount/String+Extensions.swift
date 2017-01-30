//
//  String+Extensions.swift
//  MobyDickWordCount
//
//  Created by Augusto Souza on 8/11/15.
//  Copyright (c) 2015 Augusto. All rights reserved.
//

import Foundation

extension String {
    var words: [String] {
        return split(self, maxSplit: Int.max, allowEmptySlices: false, isSeparator: {
            (c: Character) -> Bool in
            let separators = NSCharacterSet.alphanumericCharacterSet().invertedSet
            if let found = String(c).rangeOfCharacterFromSet(separators) {
                return true
            }
            return false
        }).map{ (str: String) -> String in
            return str.lowercaseString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
    }
}