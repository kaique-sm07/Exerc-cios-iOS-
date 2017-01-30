//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let a = ["a", "b", "c", "d", "e", "f"]

let b = ["a", "b"]

let x = a.filter { !b.contains($0)}

x

//a.filter(<#T##isIncluded: (String) throws -> Bool##(String) throws -> Bool#>)
