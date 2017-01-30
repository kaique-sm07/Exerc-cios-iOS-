//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let cars = ["Ferrari", "Masserati", "McLaren", "Lamborgini", "Pagani"]

let function = func

let otherCars = cars.sort({(car1: String, car2: String) -> Bool in car2 < car1})

print(otherCars)
