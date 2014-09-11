//
//  PLEmailFieldViewController.m
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import "PLEmailFieldViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PLEmailFieldViewController ()

@end

@implementation PLEmailFieldViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    RACSignal* validEmailSignal = [[self.emailField rac_textSignal] map:^id (NSString* text) {
        return @([self isValidEmail:text]);
    }];
    
    RAC(self.submitButton, enabled) = validEmailSignal;
    RAC(self.emailField, textColor) = [validEmailSignal map:^id (NSNumber* value){
        if ([value boolValue]) {
            return [UIColor greenColor];
        }
        return [UIColor redColor];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isValidEmail:(NSString*)string {
    NSString *expression = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:string
                                                    options:0
                                                      range:NSMakeRange(0, [string length])];
    
    return match != nil;
}

@end
