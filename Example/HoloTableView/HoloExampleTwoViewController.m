//
//  HoloExampleTwoViewController.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/7/28.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleTwoViewController.h"
#import <HoloTableView/HoloTableView.h>

@interface HoloExampleTwoViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HoloExampleTwoViewController

- (void)dealloc {
    NSLog(@"HoloExampleTwoViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView holo_configTableView:^(HoloTableViewConfiger * _Nonnull configer) {
        configer.cell(@"one").cls(@"HoloTableViewOneCell");
        configer.cell(@"two").cls(@"HoloTableViewTwoCell");
        configer.cell(@"three").cls(@"HoloTableViewThreeCell");
    }];
    
    [self.tableView holo_makeSection:^(HoloTableViewSectionMaker * _Nonnull make) {
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [UIColor brownColor];
        UIView *footerView = [UIView new];
        footerView.backgroundColor = [UIColor orangeColor];

        make.section(@"sectionA")
        .headerView(headerView)
        .headerViewHeight(10)
        .willDisplayHeaderViewHandler(^(UIView * _Nonnull view) {
            NSLog(@"willDisplayHeaderViewHandler");
        })
        .didEndDisplayingHeaderViewHandler(^(UIView * _Nonnull view) {
            NSLog(@"didEndDisplayingHeaderViewHandler");
        })
        .footerView(footerView)
        .footerViewHeight(20)
        .willDisplayFooterViewHandler(^(UIView * _Nonnull view) {
            NSLog(@"willDisplayFooterViewHandler");
        })
        .didEndDisplayingFooterViewHandler(^(UIView * _Nonnull view) {
            NSLog(@"didEndDisplayingFooterViewHandler");
        });
        
        make.section(@"sectionB");
        make.section(@"sectionC");
    }];
    
    [self.tableView holo_makeRowsInSection:@"sectionA" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(@"one")
        .model(@{@"bgColor": [UIColor lightGrayColor], @"text":@"Hello World!", @"height":@44})
        .didSelectHandler(^(id  _Nonnull model) {
            NSLog(@"did select : %@", model);
        })
        .willDisplayHandler(^(UITableViewCell * _Nonnull cell) {
            NSLog(@"willDisplayHandler");
        })
        .didEndDisplayingHandler(^(UITableViewCell * _Nonnull cell) {
            NSLog(@"didEndDisplayingHandler");
        });
    }];
    
    [self.tableView holo_makeRowsInSection:@"sectionB" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(@"two")
        .height(44)
        .tag(@"111");
        
        make.row(@"three")
        .height(88)
        .tag(@"222");
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
