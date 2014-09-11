//
//  PLLoginViewController.m
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import "PLLoginViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PLUserViewModel.h"
#import "PLAPIController.h"

@interface PLLoginViewController ()
@property (nonatomic, strong) PLUserViewModel* viewModel;
@end

@implementation PLLoginViewController

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
    PLAPIController* apiController = [PLAPIController APIControllerWithDomain:@"www.mysexydomain.com"];
    self.viewModel = [[PLUserViewModel alloc] initWithAPIController:apiController];
    [self bindToViewModel];
}

-(void)bindToViewModel {
    RACSignal* loggingIn = RACObserve(self.viewModel, loggingIn);
    RAC(self.activityView, hidden) = [loggingIn map:^id (NSNumber* value){
        return @(![value boolValue]);
    }];
    RAC(self.spinner, hidden) = [loggingIn not];
    
    RACSignal* formValid = [RACSignal combineLatest:@[self.emailField.rac_textSignal,
                                                      self.passwordField.rac_textSignal,
                                                      loggingIn]
                                             reduce:^id (NSString* email, NSString* password, NSNumber* loggingIn) {
                                                 return @([self isValidEmail:email] &&
                                                 password.length > 8 && ![loggingIn boolValue]);
                                         }];
    __weak typeof(self) weakSelf = self;
    RACSignal* (^signalBlock)(id) = ^RACSignal*(id input) {
        __strong typeof(self) strongSelf = weakSelf;
        
        RACSignal* loginSignal = [strongSelf.viewModel loginUserWithEmail:strongSelf.emailField.text password:strongSelf.passwordField.text];
        [loginSignal subscribeError:^(NSError* error){
            NSLog(@"Login failed!");
        } completed:^{
            NSLog(@"Successfully logged in!");
        }];
        return loginSignal;
    };
    self.submitButton.rac_command = [[RACCommand alloc] initWithEnabled:formValid
                                                            signalBlock:signalBlock];
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
