//
//  ViewController.m
//  Picker
//
//  Created by Kaique de Souza Monteiro on 18/03/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) NSArray *names;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.names = @[@"Beto", @"Ale", @"Feitosa"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerView Data Source

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.names count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    return self.names[row];
}


@end
