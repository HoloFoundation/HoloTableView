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
    NSLog(@"HoloExampleOneViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        for (NSDictionary *dict in [self _modelsFromOtherWay]) {
            make.row(@"HoloExampleOneTableViewCell")
            .model(dict)
            .didSelectHandler(^(id  _Nonnull model) {
                NSLog(@"did select model : %@", model);
            });
        }
    } withReloadAnimation:UITableViewRowAnimationNone];
}

- (NSArray *)_modelsFromOtherWay {
    return @[
             @{@"bgColor": [UIColor lightGrayColor], @"text": @"cell-1", @"height": @44},
             @{@"bgColor": [UIColor grayColor],      @"text": @"cell-2", @"height": @44},
             @{@"bgColor": [UIColor brownColor],     @"text": @"cell-3", @"height": @44},
             @{@"bgColor": [UIColor cyanColor],      @"text": @"cell-4", @"height": @44},
             @{@"bgColor": [UIColor orangeColor],    @"text": @"cell-5", @"height": @44},
             @{@"bgColor": [UIColor yellowColor],    @"text": @"cell-6", @"height": @88},
             @{@"bgColor": [UIColor darkGrayColor],  @"text": @"cell-7", @"height": @44},
             @{@"bgColor": [UIColor greenColor],     @"text": @"cell-8", @"height": @88}
             ];
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 88, HOLO_SCREEN_WIDTH, HOLO_SCREEN_HEIGHT-88);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

@end
