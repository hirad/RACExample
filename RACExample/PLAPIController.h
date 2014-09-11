//
//  PLAPIController.h
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

typedef void (^PLLoginCompletionBlock)(id, NSError*);

@interface PLAPIController : NSObject

+(instancetype)APIControllerWithDomain:(NSString*)domainURLString;

-(RACSignal*)loginUserWithEmail:(NSString*)email
                       password:(NSString*)password
                     completion:(PLLoginCompletionBlock)completionBlock;

@end
