//
//  AsteroidBeltNode.m
//  SurvivorAstronaut
//
//  Created by Kaique de Souza Monteiro on 27/05/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import "AsteroidBeltNode.h"

@interface AsteroidBeltNode()

@property (nonatomic) CGAffineTransform rotation;
@property (nonatomic) CGFloat holeAngle;
@property (nonatomic) CGFloat currentRadius;


@end

@implementation AsteroidBeltNode

-(id) initWithStartingRadius:(CGFloat) radius holeAngle:(CGFloat) holeAngle
{
    self = [super init];
    
    if (self)
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                            radius:radius
                                                        startAngle:0
                                                          endAngle:2*M_PI
                                                         clockwise:YES];
        self.currentRadius = radius;
        self.holeAngle = holeAngle;
        self.rotation = CGAffineTransformMakeRotation(arc4random());
        
        [path applyTransform:self.rotation];
        
        self.path = [path CGPath];
        
        self.fillColor = [SKColor clearColor];
        self.strokeColor = [SKColor colorWithRed:143/255.0
                                           green:1.0
                                            blue:1.0
                                           alpha:1.0];
        
        SKShader* shader = [SKShader shaderWithFileNamed:@"enemyShader.fsh"];
        
        self.strokeShader = shader;
        
        self.antialiased = NO;
        self.lineWidth = 10;
        
    }
    
    return self;
}

-(void) update
{
    self.currentRadius *= 0.99;
    
    UIBezierPath *newPath =
    [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                   radius:self.currentRadius
                               startAngle:0
                                 endAngle:2 * M_PI - self.holeAngle
                                clockwise:YES];
    
    [newPath applyTransform:self.rotation];
    
    self.path = [newPath CGPath];
    
    uint32_t categoryBitMask = self.physicsBody.categoryBitMask;
    uint32_t contactTestBitMask = self.physicsBody.contactTestBitMask;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:[newPath CGPath]];
    self.physicsBody.categoryBitMask = categoryBitMask;
    self.physicsBody.contactTestBitMask = contactTestBitMask;
    self.physicsBody.collisionBitMask = 0;
}

@end
