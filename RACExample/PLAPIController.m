//
//  PLAPIController.m
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import "PLAPIController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PLUser.h"

@implementation PLAPIController

+(instancetype)APIControllerWithDomain:(__unused NSString *)domainURLString
{
    return [[self alloc] init];
}

-(RACSignal *)loginUserWithEmail:(NSString *)email
                        password:(NSString *)password
                      completion:(PLLoginCompletionBlock)completionBlock
{
    RACSubject* dummySignal = [RACSubject subject];
    
    PLUser* dummyUser = [PLUser new];
    dummyUser.emailAddress = email;
    dummyUser.password = password;
    dummyUser.otherUserThingy = @"Some Value From the API";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (completionBlock) {
            
            completionBlock(dummyUser, nil);
        }
        
        [dummySignal sendCompleted];
    });
    
    return dummySignal;
}

@end
