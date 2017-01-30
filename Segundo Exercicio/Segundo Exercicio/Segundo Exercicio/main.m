//
//  main.m
//  Segundo Exercicio
//
//  Created by Kaique de Souza Monteiro on 10/03/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *operadores = ([[NSMutableArray alloc] init]);
        NSMutableArray *valores = ([[NSMutableArray alloc] init]);
        NSString *expression = @"( 1 + ( ( 2 + 3 ) * ( 4 * 5 ) ) )";
        NSArray *caracteres = [expression componentsSeparatedByString:@" "];
        for (NSString *caracter in caracteres) {
            if ([caracter isEqualToString:@")"]) {
                NSNumber *v1 = [NSNumber numberWithInt:[[valores lastObject] intValue]];
                [valores removeLastObject];
                NSNumber *v2 = [NSNumber numberWithInt:[[valores lastObject] intValue]];
                [valores removeLastObject];
                if ([[operadores lastObject] isEqualToString:@"*"]) {
                    [valores addObject: [NSString stringWithFormat:@"%d", [v1 intValue] * [v2 intValue]]];
                    [operadores removeLastObject];
                } else {
                    [valores addObject: [NSString stringWithFormat:@"%d", [v1 intValue] + [v2 intValue]]];
                    [operadores removeLastObject];
                }
                
                
            } else if ([caracter isEqualToString:@"*"] || [caracter isEqualToString:@"+"]) {
                [operadores addObject:caracter];
            } else if ([caracter isEqualToString:@"("]) {
            
            }
            else {
                [valores addObject:caracter];
            }
        }
        NSLog(@"%@", valores);
    }
    return 0;
}
