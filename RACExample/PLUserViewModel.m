//
//  PLUserViewModel.m
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import "PLUserViewModel.h"
#import "PLAPIController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PLUser.h"

@interface PLUserViewModel ()
@property (nonatomic, strong) PLUser* model;
@property (nonatomic, strong) PLAPIController* apiController;
@property (nonatomic, readwrite) BOOL loggingIn;
@end

@implementation PLUserViewModel

-(instancetype)initWithAPIController:(PLAPIController *)apiController
{
    self = [super init];
    if (self) {
        _apiController = apiController;
        
        RAC(self, userEmail) = RACObserve(self, model.emailAddress);
        _loggingIn = NO;
    }
    
    return self;
}

-(RACSignal *)loginUserWithEmail:(NSString*)email password:(NSString *)password
{
    self.loggingIn = YES;
    void (^completionBlock)(id, NSError*) = ^(id object, NSError* error){
        if (!error) {
            self.model = (PLUser*)object;
            [self.model setLoggedIn:YES];
        }
        self.loggingIn = NO;
    };
    RACSignal* loginSignal = [self.apiController loginUserWithEmail:self.userEmail
                                                           password:password
                                                         completion:completionBlock];
    return loginSignal;
}

@end
