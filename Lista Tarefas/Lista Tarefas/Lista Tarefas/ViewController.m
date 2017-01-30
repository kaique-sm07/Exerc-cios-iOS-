//
//  ViewController.m
//  Lista Tarefas
//
//  Created by Kaique de Souza Monteiro on 17/03/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tasksTable;
@property (nonatomic) NSMutableArray* tasks;
@property (weak, nonatomic) IBOutlet UITextField *task;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tasks = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addClick:(id)sender {
    
    NSString *task = _task.text;
    [_tasks addObject:task];
    _task.text = @"";
    [_tasksTable reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section

{
    return [_tasks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier;
    UITableViewCell *cell;
    
    
    cellIdentifier = @"SimpleTableCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellIdentifier];
        
    }
    
    cell.textLabel.text = [_tasks objectAtIndex:indexPath.row];
    
    
    
    return cell;
    
}

@end
