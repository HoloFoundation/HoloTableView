//
//  HoloExampleTwoViewController.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/7/28.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleTwoViewController.h"
#import <HoloTableView/HoloTableView.h>

@interface HoloExampleTwoViewController () <UIScrollViewDelegate, HoloTableViewDataSource, HoloTableViewDelegate>

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
    self.tableView.holo_proxy.holo_delegate = self;
//    self.tableView.editing = YES;
    
    [self.tableView holo_configureTableView:^(HoloTableViewConfiger * _Nonnull configer) {
        NSDictionary *cellClsMap = [self _cellClaMap];
        [cellClsMap enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
            configer.cell(key).cls(obj);
        }];

        configer.sectionIndexTitles(@[@"A", @"B", @"C"])
        .sectionForSectionIndexTitleHandler(^NSInteger(NSString * _Nonnull title, NSInteger index) {
            NSLog(@"section for section title: %@, index: %ld", title, (long)index);
            return index;
        });
    }];
    
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(@"sectionA")
        .header(@"HoloExampleHeaderView")
        .headerHeight(22)
        .headerModel(@{@"title":@"Hello world, header!"})
        .willDisplayHeaderHandler(^(UIView * _Nonnull header, id  _Nonnull model) {
            NSLog(@"willDisplayHeaderHandler");
        })
        .didEndDisplayingHeaderHandler(^(UIView * _Nonnull header, id  _Nonnull model) {
            NSLog(@"didEndDisplayingHeaderHandler");
        })
        .footer(@"HoloExampleFooterView")
        .footerHeight(44)
        .willDisplayFooterHandler(^(UIView * _Nonnull header, id  _Nonnull model) {
            NSLog(@"willDisplayFooterHandler");
        })
        .didEndDisplayingFooterHandler(^(UIView * _Nonnull header, id  _Nonnull model) {
            NSLog(@"didEndDisplayingFooterHandler");
        });
        
//        make.section(@"sectionB").headerHeight(44);
//        make.section(@"sectionC").headerHeight(44);
    }];
    
    [self.tableView holo_makeRowsInSection:@"sectionA" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(@"one").tag(@"A-1").model(@{@"bgColor": [UIColor lightGrayColor], @"text":@"Hello World!", @"height":@44})
        .didSelectHandler(^(id  _Nonnull model) {
            NSLog(@"did select: %@", model);
        })
        .willDisplayHandler(^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
            NSLog(@"willDisplayHandler");
        })
        .didEndDisplayingHandler(^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
            NSLog(@"didEndDisplayingHandler");
        });
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView holo_makeRowsInSection:@"sectionB" block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(@"two").height(44).tag(@"B-1").editingDeleteTitle(@"dd").editingDeleteHandler(^(id  _Nonnull model, void (^ _Nonnull completionHandler)(BOOL)) {
            
            completionHandler(YES);
        });
        
        make.row(@"two").height(44).tag(@"B-2").editingInsertHandler(^(id  _Nonnull model) {
            NSLog(@"editing insert handler: %@", model);
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
                make.row(@"two").height(88).tag(@"insert");
            } withReloadAnimation:UITableViewRowAnimationNone];
        });
        
        make.row(@"three").height(88).tag(@"B-3").moveHandler(^(NSIndexPath * _Nonnull atIndexPath, NSIndexPath * _Nonnull toIndexPath, void (^ _Nonnull completionHandler)(BOOL)) {
            
            completionHandler(YES);
        });
        
//        HoloTableViewRowSwipeAction *action1 = [HoloTableViewRowSwipeAction rowSwipeActionWithStyle:HoloTableViewRowSwipeActionStyleNormal title:@"a1"];
//        HoloTableViewRowSwipeAction *action2 = [HoloTableViewRowSwipeAction rowSwipeActionWithStyle:HoloTableViewRowSwipeActionStyleDestructive title:@"a2"];
//        HoloTableViewRowSwipeAction *action3 = [HoloTableViewRowSwipeAction rowSwipeActionWithStyle:HoloTableViewRowSwipeActionStyleNormal title:@"a3"];
        NSDictionary *action1 = @{@"title":@"a1", @"style":@1};
        NSDictionary *action2 = @{@"title":@"a2", @"style":@0};
        NSDictionary *action3 = @{@"title":@"a3", @"style":@0};
        make.row(@"three").height(88).tag(@"B-4")
        .trailingSwipeActions(@[action1, action2, action3])
        .trailingSwipeHandler(^(id  _Nonnull action, NSInteger index, void (^ _Nonnull completionHandler)(BOOL)) {
            NSLog(@"trailing---%@---%ld", [action valueForKey:@"title"], index);
            completionHandler(YES);
        });
    }];
    
    [self.tableView reloadData];
}


- (NSDictionary *)_cellClaMap {
    return @{
             @"one"   : @"HoloExampleOneTableViewCell",
             @"two"   : @"HoloExampleTwoTableViewCell",
             @"three" : @"HoloExampleThreeTableViewCell"
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
