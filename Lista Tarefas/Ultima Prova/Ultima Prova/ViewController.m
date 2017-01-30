//
//  ViewController.m
//  Ultima Prova
//
//  Created by Kaique de Souza Monteiro on 18/03/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *notesTable;
@property (weak, nonatomic) IBOutlet UITextField *minimalText;
@property (weak, nonatomic) IBOutlet UITextField *testText;
@property (weak, nonatomic) IBOutlet UITextField *weightText;
@property (nonatomic) int cellsNumber;
@property (nonatomic) float minimalNote;
@property (nonatomic) float weightLast;
@property (nonatomic) float finalNote;
@property (weak, nonatomic) IBOutlet UILabel *auxNoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UIButton *calcButton;

@end

@implementation ViewController

#pragma Inicializadores
- (void)viewDidLoad {
    [super viewDidLoad];
    /*** Inicializa as variaveis de instancia, esconde as labels de resultado e desabilita o botão de resultado, alem de definir que o teclado sera escondido caso o usuario toque fora do teclado ou do campo texto.
     ***/
    _cellsNumber = 0;
    _auxNoteLabel.hidden = YES;
    _noteLabel.hidden = YES;
    _calcButton.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                    action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// Função que define que oteclado será escondido caso o usuario toque fora do teclado ou do campo texto
-(void)dismissKeyboard {
    
    [self.view endEditing:YES];
}

#pragma Table

/// Função que define o numero de linhas da tabela
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _cellsNumber;
}

/// Função que popula a tabela com os campos de nota, peso e a ordem da prova
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier;
    UITableViewCell *cell;
    
    cellIdentifier = @"SimpleTableCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        UITextField *noteField = [self createNoteField];
        [cell.contentView addSubview:noteField];
    
        UITextField *weightField = [self createWeightField];
        [cell.contentView addSubview:weightField];
    
        //Trecho que cria o label da ordem da prova
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
        testLabel.font = [UIFont systemFontOfSize:15];
        testLabel.text = [NSString stringWithFormat:@"Prova %ld", (long)indexPath.row + 1];
        [cell.contentView addSubview:testLabel];
    }
    
    return cell;
    
}

///Função que retorna o textfield de peso da prova
-(UITextField *) createWeightField {
    
    UITextField *weightField = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, 80, 30)];
    weightField.borderStyle = UITextBorderStyleRoundedRect;
    weightField.font = [UIFont systemFontOfSize:15];
    weightField.placeholder = @"Peso";
    weightField.autocorrectionType = UITextAutocorrectionTypeNo;
    weightField.keyboardType = UIKeyboardTypeDecimalPad;
    weightField.returnKeyType = UIReturnKeyDone;
    weightField.clearButtonMode = UITextFieldViewModeWhileEditing;
    weightField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    weightField.tag = 1;
    return weightField;

}

///Função que retorna o textfield da nota da prova
-(UITextField *) createNoteField {

    UITextField *noteField = [[UITextField alloc] initWithFrame:CGRectMake(260, 10, 80, 30)];
    noteField.borderStyle = UITextBorderStyleRoundedRect;
    noteField.font = [UIFont systemFontOfSize:15];
    noteField.placeholder = @"Nota";
    noteField.autocorrectionType = UITextAutocorrectionTypeNo;
    noteField.keyboardType = UIKeyboardTypeDecimalPad;
    noteField.returnKeyType = UIReturnKeyDone;
    noteField.clearButtonMode = UITextFieldViewModeWhileEditing;
    noteField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    noteField.tag = 2;
    return noteField;
}

#pragma Ações dos botões
///Armazena as informações inseridas pelo usuário e atualiza as tabelas com os campos adequados
- (IBAction)okClick:(id)sender {
    _cellsNumber = [_testText.text intValue];
    _cellsNumber--;
    _minimalNote = [[_minimalText.text stringByReplacingOccurrencesOfString:@"," withString:@"."]
                    floatValue];
    _weightLast = [[_weightText.text stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue];
    _calcButton.enabled = YES;
    [_notesTable reloadData];
}

///Realiza os calculos da nota final e exibe nas labels a nota final
- (IBAction)calcClick:(id)sender {
  
    int totalWeight = _weightLast;
    float totalNote = 0;
    for (int i = 0; i < _cellsNumber; i++) {
        UITableViewCell *cell = [_notesTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        UITextField *wheight=(UITextField *)[cell.contentView viewWithTag:1];
        UITextField *note=(UITextField *)[cell.contentView viewWithTag:2];
        totalWeight += [wheight.text intValue];
        totalNote += [[note.text stringByReplacingOccurrencesOfString:@"," withString:@"."]floatValue] * [wheight.text intValue];
    }
    _finalNote = ((_minimalNote * totalWeight) - totalNote) / _weightLast;
    _auxNoteLabel.hidden = NO;
    _noteLabel.hidden = NO;
    if (_finalNote < 0) {
        _finalNote = 0;
    } 
    _noteLabel.text = [NSString stringWithFormat:@"%.2f", _finalNote ];
}

///Limpa todos os campos fixos e remove as linhas da tabela
- (IBAction)clearClick:(id)sender {
 
    _cellsNumber = 0;
    _auxNoteLabel.hidden = YES;
    _noteLabel.hidden = YES;
    _calcButton.enabled = NO;
    _minimalText.text = @"";
    _testText.text = @"";
    _weightText.text = @"";
    [_notesTable reloadData];
}

@end
