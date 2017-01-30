//
//  ViewController.m
//  Cronometro
//
//  Created by Kaique de Souza Monteiro on 16/03/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSTimer *timer;
@property (nonatomic)int countSec;
@property (nonatomic)int countMin;
@property (weak, nonatomic) IBOutlet UILabel *seconds;
@property (weak, nonatomic) IBOutlet UILabel *minutes;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  Inicializa os contadores de minuto e segundo e desabilita os botoes stop e reset
    _countSec = 0;
    _countMin = 0;
    self.stopButton.enabled = NO;
    self.resetButton.enabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  Clique do botao reset, que inicializa os contadores de minuto e segundo e habilita o botao start
- (IBAction)reset:(id)sender {
    self.seconds.text = @"00 s";
    self.minutes.text = @"00 m";
    self.startButton.enabled = YES;
    _countSec = 0;
    _countMin = 0;
    
    
}

//  Clique do botao stop, que para o cronometro, desabilita a si proprio e habilita os botoes start e reset
- (IBAction)stop:(id)sender {
    [_timer invalidate];
    self.startButton.enabled = YES;
    self.stopButton.enabled = NO;
    self.resetButton.enabled = YES;
}

/*  Clique do botao start, que inicia o contador, habilita o botao stop e desabilita a si proprio e o botao reset
 */
- (IBAction)start:(id)sender {
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick)
            userInfo:nil repeats:YES];
    self.startButton.enabled = NO;
    self.stopButton.enabled = YES;
    self.resetButton.enabled = NO;
    

}

/***
 Funcao que incrementa o contador de segundos e modifica os textos dos labels para refletir contador.
 ***/
-(void)onTick{
    _countSec++;
    
    if (_countSec > 59) {
        _countSec = 0;
        _countMin++;
        self.minutes.text = [NSString stringWithFormat:@"%02i s", _countMin];
    }

    self.seconds.text = [NSString stringWithFormat:@"%02i s", _countSec];
    
}



@end
