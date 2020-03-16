//
//  HoloViewController.m
//  HoloTableView
//
//  Created by gonghonglou on 07/28/2019.
//  Copyright (c) 2019 gonghonglou. All rights reserved.
//

#import "HoloViewController.h"
#import <HoloTableView/HoloTableView.h>
#import "HoloExampleHeaderView.h"
#import "HoloExampleFooterView.h"
#import "HoloExampleTableViewCell.h"

#define HOLO_SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define HOLO_SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

@interface HoloViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloViewController

- (void)dealloc {
    NSLog(@"HoloExampleOneViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(50, 44, HOLO_SCREEN_WIDTH - 100, 44);
    [button setTitle:@"add a cell" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"a")
        .header(HoloExampleHeaderView.class)
        .headerModel(@{@"title":@"header"})
        .footer(HoloExampleFooterView.class)
        .footerModel(@{@"title":@"footer"})
        .footerHeight(100)
        .makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            make.row(HoloExampleTableViewCell.class).model(@{@"bgColor": [UIColor cyanColor], @"text": @"cell", @"height": @44});
        });
    }];
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        for (NSDictionary *dict in [self _modelsFromOtherWay]) {
            make.row(HoloExampleTableViewCell.class)
            .model(dict)
            .didSelectHandler(^(id  _Nonnull model) {
                NSLog(@"did select model : %@", model);
            });
        }
    }];
    
    [self.tableView reloadData];
}

- (NSArray *)_modelsFromOtherWay {
    return @[
        @{@"bgColor": [UIColor yellowColor],   @"text": @"cell-1", @"height": @66},
        @{@"bgColor": [UIColor cyanColor],     @"text": @"cell-2", @"height": @66},
        @{@"bgColor": [UIColor orangeColor],   @"text": @"cell-3", @"height": @66},
    ];
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    [self.tableView holo_insertRowsAtIndex:0 inSection:@"a" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(HoloExampleTableViewCell.class).model(@{@"bgColor": [UIColor redColor], @"text": @"cell", @"height": @44});
    } withReloadAnimation:UITableViewRowAnimationNone];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 100, HOLO_SCREEN_WIDTH, HOLO_SCREEN_HEIGHT - 100);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

@end
