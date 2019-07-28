//
//  HoloExampleOneViewController.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/7/28.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleOneViewController.h"
#import <HoloTableView/HoloTableView.h>

@interface HoloExampleOneViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloExampleOneViewController

- (void)dealloc {
    NSLog(@"------HoloExampleOneViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView holo_makeSection:^(HoloTableViewMaker * _Nonnull make) {
        make.row(@"HoloTableViewOneCell")
        .model(@{@"bgColor": [UIColor lightGrayColor], @"text":@"Hello World!--1", @"height":@44})
        .didSelectHandler(^(id  _Nonnull model) {
            NSLog(@"----%@", model);
        });
        
        make.row(@"HoloTableViewOneCell")
        .model(@{@"bgColor": [UIColor redColor], @"text":@"Hello World!--2", @"height":@44});
        
        make.row(@"HoloTableViewOneCell")
        .model(@{@"bgColor": [UIColor yellowColor], @"text":@"Hello World!--3", @"height":@44});
    }];
    
    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

@end
