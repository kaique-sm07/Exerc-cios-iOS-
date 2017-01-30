//
//  AsteroidBeltNode.h
//  SurvivorAstronaut
//
//  Created by Kaique de Souza Monteiro on 27/05/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AsteroidBeltNode : SKShapeNode

-(id) initWithStartingRadius:(CGFloat) radius holeAngle:(CGFloat) holeAngle;

-(void) update;

@end
