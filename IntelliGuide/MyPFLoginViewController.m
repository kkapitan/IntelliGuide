//
//  MyPFLoginViewController.m
//  IntelliGuide
//
//  Created by Krystian Paszek on 20.05.2015.
//  Copyright (c) 2015 Krzysztof Kapitan. All rights reserved.
//

#import "MyPFLoginViewController.h"

@implementation MyPFLoginViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Intelliguide";
    [label setFont:[UIFont systemFontOfSize:36]];
    [self.logInView setLogo:label];
}

@end
