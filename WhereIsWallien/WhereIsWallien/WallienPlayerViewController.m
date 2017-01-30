//
//  WallienViewController.m
//  WhereIsWallien
//
//  Created by SERGIO J RAFAEL ORDINE on 11/28/13.
//  Copyright (c) 2013 SERGIO J RAFAEL ORDINE. All rights reserved.
//

#import "WallienPlayerViewController.h"

@interface WallienPlayerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *superiorTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *inferiorTitleLabel;

@end

@implementation WallienPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIFont* font = [UIFont fontWithName:@"AlienLeague" size:40];

    self.superiorTitleLabel.font = font;
    self.inferiorTitleLabel.font = font;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
