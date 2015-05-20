//
//  MyPFSingUpViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 20.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "MyPFSingUpViewController.h"

@implementation MyPFSingUpViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Intelliguide";
    [label setFont:[UIFont systemFontOfSize:36]];
    [self.signUpView setLogo:label];
}

@end
