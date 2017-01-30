//
//  GameScene.m
//  SurvivorAstronaut
//
//  Created by Kaique de Souza Monteiro on 27/05/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import "GameScene.h"

@import AVFoundation;
#import "AsteroidBeltNode.h"

@interface GameScene()

@property (nonatomic, strong) AVPlayer *bgVideoPlayer;
@property (nonatomic) unsigned long score;
@property (nonatomic) unsigned long lives;
@property (nonatomic,strong) SKLabelNode *scoreLabel;
@property (nonatomic,strong) SKLabelNode *livesLabel;
@property (nonatomic,strong) SKNode* planetNode;
@property (nonatomic,strong) SKNode* astronautNode;
@property (nonatomic,strong) NSMutableArray* enemies;
@property (nonatomic) CGFloat astronautAngle;
@property (nonatomic) CGFloat astronautOrbitRadius;
@property (nonatomic) CGPoint astronautSpeed;
@property (nonatomic, strong) SKAction* damageAction;
@property (nonatomic, strong) SKAction* scoreAction;
@property (nonatomic, strong) AVAudioPlayer *bgMusicPlayer;
@property (nonatomic,strong) SKLabelNode *gameoverLabel;
@property (nonatomic,strong) SKLabelNode *tutorial;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic) float interval;
@property (nonatomic, strong) SKAction* loseAction;


@end

@implementation GameScene

static const uint32_t astronautCategory = 0x1 << 0; // 1
static const uint32_t enemyCategory   = 0x1 << 1; // 2
static const uint32_t planetCategory   = 0x1 << 2; // 4

-(void)didMoveToView:(SKView *)view {
    
    [view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)]];
    
}

-(void) handlePanGesture: (UIPanGestureRecognizer*) panGestureRecognizer
{
    self.astronautSpeed = [panGestureRecognizer velocityInView:self.view];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        //VIDEO BACKGROUND
        SKVideoNode *videoNode = [[SKVideoNode alloc]
                                  initWithAVPlayer:self.bgVideoPlayer];
        videoNode.size = self.size;
        videoNode.zPosition = -1;
        videoNode.alpha = 0.4;
        [self addChild:videoNode];
        [videoNode play];
        self.scoreLabel = (SKLabelNode*) [self childNodeWithName:@"scoreLabel"];
        self.livesLabel = (SKLabelNode*) [self childNodeWithName:@"livesLabel"];
        self.planetNode = [self childNodeWithName:@"planet"];
        self.astronautNode = [self.planetNode childNodeWithName:@"astronaut"];
        
        self.planetNode.physicsBody.categoryBitMask = planetCategory;
        self.planetNode.physicsBody.contactTestBitMask = enemyCategory;
        self.planetNode.physicsBody.collisionBitMask = 0;
        
        self.astronautNode.physicsBody.categoryBitMask = astronautCategory;
        self.astronautNode.physicsBody.contactTestBitMask = enemyCategory;
        self.astronautNode.physicsBody.collisionBitMask = 0;
        
        self.damageAction = [SKAction sequence:
                             @[
                               [SKAction playSoundFileNamed:@"hit.wav" waitForCompletion:NO],
                               [SKAction colorizeWithColor:[SKColor redColor]
                                          colorBlendFactor:1.0
                                                  duration:0.0],
                               
                               [SKAction colorizeWithColorBlendFactor:0.0
                                                             duration:1.0]
                               
                               ]
                             ];        self.scoreAction = [SKAction group:@[[SKAction sequence:
                               @[
                                 [SKAction scaleTo:2.0 duration:0.2],
                                 [SKAction scaleTo:1.0 duration:0.2]
                                 ]
                               ],
                              
                              [SKAction sequence:
                               @[
                                 [SKAction runBlock:^{
            self.scoreLabel.color = [SKColor orangeColor];
            self.scoreLabel.colorBlendFactor = 1.0;
        }],
                                 
                                 [SKAction waitForDuration:0.2],
                                 
                                 [SKAction runBlock:^{
            self.scoreLabel.colorBlendFactor = 0;
        }],
                                 ]
                               ],
                              ]
                            ];
        
        self.scoreAction = [SKAction group:
                            @[
                              [SKAction playSoundFileNamed:@"score.wav" waitForCompletion:NO],
                              [SKAction sequence:
                               @[
                                 [SKAction scaleTo:2.0 duration:0.2],
                                 [SKAction scaleTo:1.0 duration:0.2]
                                 ]
                               ],
                              
                              [SKAction sequence:
                               @[
                                 [SKAction runBlock:^{
            self.scoreLabel.color = [SKColor orangeColor];
            self.scoreLabel.colorBlendFactor = 1.0;
        }],
                                 
                                 [SKAction waitForDuration:0.2],
                                 
                                 [SKAction runBlock:^{
            self.scoreLabel.colorBlendFactor = 0;
        }],
                                 ]
                               ],
                              ]
                            ];
        
        self.loseAction = [SKAction sequence:
                            @[
                              [SKAction playSoundFileNamed:@"gameOver.wav" waitForCompletion:NO],
                              [SKAction runBlock:^{
            self.gameoverLabel.hidden = NO;
            
            // Tap to replay
            [self.scene.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                                   initWithTarget:self action:@selector(handleTapGesture:)]];
            
            [_bgMusicPlayer pause];
            self.scene.view.paused = YES;
            
        }]
                              ]
                            ];
        
        self.physicsWorld.contactDelegate = self;
        
        [self setup];
        
        
        
        
        
        self.gameoverLabel = (SKLabelNode*) [self childNodeWithName:@"toque"];
        self.gameoverLabel.hidden = YES;
        
        self.tutorial = (SKLabelNode*) [self childNodeWithName:@"tutorial"];
    }
    
    return self;
}

- (void)setup
{
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.score = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%lu",self.score ];
    self.lives = 5;
    self.livesLabel.text = [NSString stringWithFormat:@"%lu",self.lives ];
    self.astronautAngle = 0;
    self.astronautOrbitRadius = self.planetNode.frame.size.width/2 +
    self.astronautNode.frame.size.width/2 + 50;
    self.interval = 2;
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval
                                                  target:self
                                                selector:@selector(addEnemy:)
                                                userInfo:nil
                                                 repeats:YES];
    [self playBackgroundMusic];
}

- (void)damageAstronaut
{
    self.lives--;
    self.livesLabel.text = [NSString stringWithFormat:@"%lu",self.lives ];
    
    if(self.lives == 0)
    {
        self.gameoverLabel.hidden = NO;
       // self.scene.view.paused = YES;
        
        // Tap to replay
        [self.scene.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(handleTapGesture:)]];
        
        [_bgMusicPlayer pause];
        
        [self.astronautNode runAction:self.loseAction];
        
    } else
    {
        [self.astronautNode runAction:self.damageAction];
        
    }
}

-(void) handleTapGesture: (UITapGestureRecognizer*) tapGestureRecognizer
{
    // Restart de Game
    [self.scene.view removeGestureRecognizer:tapGestureRecognizer];
    self.scene.view.paused = NO;
    self.gameoverLabel.hidden = YES;
    
    [self.enemies makeObjectsPerformSelector:@selector(removeFromParent)];
    
    [self.enemies removeAllObjects];
    
    [self setup];
    
}

- (void)addScore
{
    self.score++;
    self.scoreLabel.text = [NSString stringWithFormat:@"%lu",self.score ];
    if (self.interval > 1.1) {
        [self.timer invalidate];
        self.timer = nil;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval -= 0.05
                                                      target:self
                                                    selector:@selector(addEnemy:)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    [self.scoreLabel runAction:self.scoreAction];
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [self.enemies makeObjectsPerformSelector:@selector(update)];
    self.astronautSpeed = CGPointMake(self.astronautSpeed.x / 1.1,
                                      self.astronautSpeed.y);
    self.astronautAngle += self.astronautSpeed.x / 2000;
    
    CGFloat astronautX = self.astronautOrbitRadius * cos(self.astronautAngle);
    CGFloat astronautY = self.astronautOrbitRadius * sin(self.astronautAngle);
    
    self.astronautNode.position = CGPointMake(astronautX, astronautY);
    
    
}

- (AVPlayer *)bgVideoPlayer
{
    if (!_bgVideoPlayer) {
        NSURL *url = [NSURL fileURLWithPath:
                      [[NSBundle mainBundle] pathForResource:@"background"
                                                      ofType:@"mp4"]];
        
        _bgVideoPlayer = [[AVPlayer alloc] initWithURL:url];
        
        _bgVideoPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(bgVideoDidEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[_bgVideoPlayer currentItem]];
    }
    
    return _bgVideoPlayer;
}

- (void)bgVideoDidEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

-(NSMutableArray *) enemies
{
    if(!_enemies)
    {
        _enemies = [NSMutableArray array];
    }
    
    return _enemies;
}

-(void) addEnemy: (NSTimer*) timer
{
    
    self.tutorial.hidden = YES;
    AsteroidBeltNode *newEnemy =
    [[AsteroidBeltNode alloc] initWithStartingRadius:self.size.width
                                           holeAngle:M_PI_2];
    
    newEnemy.physicsBody = [SKPhysicsBody
                            bodyWithEdgeChainFromPath:newEnemy.path];
    newEnemy.physicsBody.categoryBitMask = enemyCategory;
    newEnemy.physicsBody.contactTestBitMask = astronautCategory | planetCategory;
    newEnemy.physicsBody.collisionBitMask = 0;
    
    [self.enemies addObject:newEnemy];
    
    [self addChild:newEnemy];
    
}

- (void) playBackgroundMusic
{
    if (!_bgMusicPlayer) {
        NSURL *musicFileName = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                       pathForResource:@"back" ofType:@"wav"]];
        
        NSError *error = nil;
        
        _bgMusicPlayer = [[AVAudioPlayer alloc]
                          initWithContentsOfURL:musicFileName
                          error:&error];
        _bgMusicPlayer.numberOfLoops = -1; // tocar para sempre
        
        [_bgMusicPlayer prepareToPlay];
    }
    
    [_bgMusicPlayer pause];
    
    _bgMusicPlayer.currentTime = 0;
    
    [_bgMusicPlayer play];
}


-(void) didBeginContact:(SKPhysicsContact *)contact
{
    uint32_t collision =
    (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    
    SKNode *enemy = contact.bodyA.categoryBitMask == enemyCategory ?
    contact.bodyA.node :
    contact.bodyB.node;
    
    // didBeginContact em alguns casos é chamado mais de uma vez
    // aqui verificamos se o objeto ainda tem um parent, pois caso
    // ele já tenha executado removeFromParent enemy.parent será nil
    if(enemy.parent){
        
        if (collision == (astronautCategory | enemyCategory)) {
            
            // Inimigo atingiu o astronaulta
            [self damageAstronaut];
            
            
        } else if (collision == (planetCategory | enemyCategory)) {
            
            // Inimigo atingiu o planeta
            [self addScore];
            
        }
    }
    
    // remove o inimigo se sempre que entrarem em contato com qualquer coisa
    [self.enemies removeObject:enemy];
    [enemy removeFromParent];
    
}




@end
