//
//  PLUserViewModel.h
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PLAPIController;
@class RACSignal;

@interface PLUserViewModel : NSObject

@property (nonatomic, strong) NSString* userEmail;
@property (nonatomic, readonly, getter = isLoggingIn) BOOL loggingIn;

-(instancetype)initWithAPIController:(PLAPIController*)apiController;
-(RACSignal*)loginUserWithEmail:(NSString*)email password:(NSString*)password;

@end
