//
//  PLLoginViewController.h
//  RACExample
//
//  Created by Hirad Motamed on 2014-09-10.
//  Copyright (c) 2014 Pendar Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLLoginViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView* activityView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView* spinner;
@property (nonatomic, weak) IBOutlet UIButton* submitButton;
@property (nonatomic, weak) IBOutlet UITextField* emailField;
@property (nonatomic, weak) IBOutlet UITextField* passwordField;

@end
