//
//  Car.m
//  Memory
//
//  Created by Kaique de Souza Monteiro on 11/03/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import "Car.h"

@implementation Car

{
    NSMutableArray *_wheels;
}

-(NSMutableArray *) wheels{
    return _wheels;
}

-(void) setWheels : (NSMutableArray *) newWheels{
    _wheels = newWheels;
}

@end
