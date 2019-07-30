//
//  HoloExampleOneViewController.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/7/28.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleOneViewController.h"
#import <HoloTableView/HoloTableView.h>

@interface HoloExampleOneViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloExampleOneViewController

- (void)dealloc {
    NSLog(@"HoloExampleOneViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        for (NSDictionary *dict in [self _modelsFromOtherWay]) {
            make.row(@"HoloTableViewOneCell")
            .model(dict)
            .didSelectHandler(^(id  _Nonnull model) {
                NSLog(@"did select model : %@", model);
            });
        }
    }];
    [self.tableView reloadData];
    
    self.tableView.holo_tableViewProxy.holo_tableScrollDelegate = self;
}

- (NSArray *)_modelsFromOtherWay {
    return @[
             @{@"bgColor": [UIColor lightGrayColor], @"text":@"Hello World!--1", @"height":@44},
             @{@"bgColor": [UIColor grayColor], @"text":@"Hello World!--2", @"height":@44},
             @{@"bgColor": [UIColor magentaColor], @"text":@"Hello World!--3", @"height":@44},
             @{@"bgColor": [UIColor cyanColor], @"text":@"Hello World!--4", @"height":@44},
             @{@"bgColor": [UIColor redColor], @"text":@"Hello World!--5", @"height":@44},
             @{@"bgColor": [UIColor yellowColor], @"text":@"Hello World!--6", @"height":@88},
             @{@"bgColor": [UIColor cyanColor], @"text":@"Hello World!--7", @"height":@44},
             @{@"bgColor": [UIColor greenColor], @"text":@"Hello World!--8", @"height":@22}
             ];
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
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
