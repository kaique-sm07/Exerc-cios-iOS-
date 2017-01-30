//
//  main.m
//  Memory
//
//  Created by Kaique de Souza Monteiro on 11/03/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wheel.h"
#import "Car.h"

int main(int argc, const char * argv[]) {
    
    Wheel *wheel1 = [[Wheel alloc] init];
    Wheel *wheel2 = [[Wheel alloc] init];
    Wheel *wheel3 = [[Wheel alloc] init];
    Wheel *wheel4 = [[Wheel alloc] init];
    
    wheel1.diameter = [[NSString alloc] initWithString:@"13''"];
    wheel2.diameter = [[NSString alloc] initWithString:@"13''"];
    wheel3.diameter = [[NSString alloc] initWithString:@"13''"];
    wheel4.diameter = [[NSString alloc] initWithString:@"13''"];
    
    NSMutableArray *arrWheels = [[NSMutableArray alloc] init];
    [arrWheels addObject:wheel1];
    [arrWheels addObject:wheel2];
    [arrWheels addObject:wheel3];
    [arrWheels addObject:wheel4];
    
    Car *car = [[Car alloc] init];
    car.wheels = arrWheels;
    
    
    
    return 0;
}
