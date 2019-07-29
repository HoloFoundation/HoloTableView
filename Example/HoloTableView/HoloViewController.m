//
//  HoloViewController.m
//  HoloTableView
//
//  Created by gonghonglou on 07/28/2019.
//  Copyright (c) 2019 gonghonglou. All rights reserved.
//

#import "HoloViewController.h"
#import "HoloExampleOneViewController.h"
#import "HoloExampleTwoViewController.h"

@interface HoloViewController ()

@end

@implementation HoloViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *oneButton = [self createButtonWithTitle:@"one vc"];
    oneButton.frame = CGRectMake(40, 200, self.view.frame.size.width-40*2, 44);
    [self.view addSubview:oneButton];
    [oneButton addTarget:self action:@selector(presentOneVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *twoButton = [self createButtonWithTitle:@"two vc"];
    twoButton.frame = CGRectMake(40, 300, self.view.frame.size.width-40*2, 44);
    [self.view addSubview:twoButton];
    [twoButton addTarget:self action:@selector(presentTwoVC) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)createButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.layer.cornerRadius = 4.0;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1.0;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (void)presentOneVC {
    [self presentViewController:[HoloExampleOneViewController new] animated:YES completion:nil];
}

- (void)presentTwoVC {
    [self presentViewController:[HoloExampleTwoViewController new] animated:YES completion:nil];
}

@end
