//
//  PLUser.h
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLUser : NSObject

@property (nonatomic, strong) NSString* emailAddress;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, assign, getter = isLoggedIn) BOOL loggedIn;
@property (nonatomic, strong) NSString* otherUserThingy;

@end
