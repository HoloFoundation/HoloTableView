//
//  HoloExampleTwoViewController.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/7/28.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleTwoViewController.h"
#import <HoloTableView/HoloTableView.h>

@interface HoloExampleTwoViewController () <UIScrollViewDelegate, HoloTableViewDataSource>

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
    self.tableView.holo_proxy.holo_scrollDelegate = self;
    self.tableView.holo_proxy.holo_dataSource = self;
    self.tableView.editing = YES;
    
    [self.tableView holo_configTableView:^(HoloTableViewConfiger * _Nonnull configer) {
        NSDictionary *cellClsMap = [self _cellClaMap];
        [cellClsMap enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
            configer.cell(key).cls(obj);
        }];
        
        configer.sectionIndexTitles(@[@"A", @"B", @"C"])
        .sectionForSectionIndexTitleHandler(^NSInteger(NSArray<NSString *> * _Nonnull sectionIndexTitles, NSString * _Nonnull title, NSInteger index) {
            NSLog(@"section for section title: %@, index: %ld", title, (long)index);
            return index;
        });
    }];
    
    [self.tableView holo_makeSection:^(HoloTableViewSectionMaker * _Nonnull make) {
        UIView *header = [UIView new];
        header.backgroundColor = [UIColor brownColor];
        UIView *footer = [UIView new];
        footer.backgroundColor = [UIColor orangeColor];

        make.section(@"sectionA")
        .header(header)
        .headerHeight(10)
        .willDisplayHeaderHandler(^(UIView * _Nonnull view) {
            NSLog(@"willDisplayHeaderHandler");
        })
        .didEndDisplayingHeaderHandler(^(UIView * _Nonnull view) {
            NSLog(@"didEndDisplayingHeaderHandler");
        })
        .footer(footer)
        .footerHeight(20)
        .willDisplayFooterHandler(^(UIView * _Nonnull view) {
            NSLog(@"willDisplayFooterHandler");
        })
        .didEndDisplayingFooterHandler(^(UIView * _Nonnull view) {
            NSLog(@"didEndDisplayingFooterHandler");
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


- (NSDictionary *)_cellClaMap {
    return @{
             @"one"     :@"HoloExampleOneTableViewCell",
             @"two"     :@"HoloExampleTwoTableViewCell",
             @"three"   :@"HoloExampleThreeTableViewCell"
             };
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
}

#pragma mark - HoloTableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"---");
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
