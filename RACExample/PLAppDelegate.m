//
//  PLAppDelegate.m
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import "PLAppDelegate.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PLTextFieldViewController.h"
#import "PLEmailFieldViewController.h"
#import "PLLoginViewController.h"

@interface NSArray (FunctionalStuff)

-(NSArray*)map:(id (^)(id object))mappingBlock;

@end

@implementation NSArray (FunctionalStuff)

-(NSArray *)map:(id (^)(id))mappingBlock
{
    NSMutableArray* result = [@[] mutableCopy];
    for (id object in self) {
        [result addObject:mappingBlock(object)];
    }
    return [NSArray arrayWithArray:result];
}

@end

void sequencesExample() {
    
    NSArray* numbers = @[@9, @7, @10, @4, @5, @6];
    
    // Doubling numbers without higher order functions
    NSMutableArray* doubledNumbers = [@[] mutableCopy];
    for (NSNumber* number in numbers) {
        [doubledNumbers addObject:@([number integerValue] * 2)];
    }
    NSLog(@"Manual Doubling result: %@", doubledNumbers);
    
    // with a map method
    NSArray* mappedResult = [numbers map:^id(NSNumber* number) {
        return @([number integerValue] * 2);
    }];
    NSLog(@"Mapped Results: %@", mappedResult);
    
    // with ReactiveCocoa
    RACSequence* stream = [numbers rac_sequence];
    stream = [stream map:^id (NSNumber* num){
        return @([num integerValue] * 2);
    }];
    NSLog(@"RAC Results: %@", [stream array]);
    
    // filtering with ReactiveCocoa
    NSLog(@"Even numbers: %@", [[[numbers rac_sequence] filter:^BOOL(NSNumber* number){
        return [number integerValue] % 2 == 0;
    }] array]);
    
    // tripling the even numbers
    NSLog(@"Tripled even numbers: %@", [[[[numbers rac_sequence] filter:^BOOL(NSNumber* number){
        return [number integerValue] % 2 == 0;
    }] map:^id(NSNumber* number){
        return @([number integerValue] * 3);
    }] array]);
}

@implementation PLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[PLLoginViewController alloc] initWithNibName:nil bundle:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    sequencesExample();
    
    return YES;
}

@end
