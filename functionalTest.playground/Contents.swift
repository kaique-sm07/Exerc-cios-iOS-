//: Playground - noun: a place where people can play

import UIKit


func compose<A>(f1:A->A, f2:A->A)-> (A->A) {
    return {  x in
        f2(f1(x))
    }
}


infix operator ∘ {}

func ∘<A> (shl:A->A, rhl:A->A) -> (A->A) {
    return compose(rhl, f2: shl)
}


let f = {(x:Int) -> (Int) in return x*x}
let g = {(x:Int) -> (Int) in return x+4}
let h = {(x:Int) -> (Int) in return x*2}

func compounder<A>(array: [A -> A]) -> A->A {
    return array.reduce({x in return x}) {  $0 ∘ $1 }
}

let function = compounder([h,g,f])
function(2)

(g ∘ f)(2)