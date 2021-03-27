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

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *modelArray;

@end

@implementation HoloViewController

- (void)dealloc {
    NSLog(@"HoloExampleOneViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.tableView];
    
    
    [self makeSectionByMaker];
    
//    [self makeRowListWithDefaultSection];
    
//    [self makeSectionListByObject];
}


#pragma mark - Maker

- (void)makeSectionByMaker {
    [self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
        make.section(TAG)
        .header(HoloExampleHeaderView.class).headerModel(@{@"title":@"header"})
        .footer(HoloExampleFooterView.class).footerModel(@{@"title":@"footer"}).footerHeight(100)
        .makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
            for (NSDictionary *dict in self.modelArray) {
                make.row(HoloExampleTableViewCell.class).model(dict).didSelectHandler(^(id  _Nullable model) {
                    NSLog(@"did select row : %@", model);
                });
            }
        });
        
        // make.section(@"1")
        // make.section(@"2")
        // ...
    }];
    [self.tableView reloadData];
}

- (void)insertRowToSectionWithReloadAnimation {
    [self.tableView holo_insertRowsAtIndex:0 inSection:TAG block:^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(HoloExampleTableViewCell.class).model(@{@"bgColor": [UIColor redColor], @"text": @"cell", @"height": @44});
    } withReloadAnimation:UITableViewRowAnimationNone];
}

- (void)makeRowListWithDefaultSection {
    [self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
        for (NSDictionary *dict in self.modelArray) {
            make.row(HoloExampleTableViewCell.class).model(dict).didSelectHandler(^(id  _Nullable model) {
                NSLog(@"did select row : %@", model);
            });
        }
    }];
    [self.tableView reloadData];
}


#pragma mark - Object

- (void)makeSectionListByObject {
    HoloTableSection *section = [HoloTableSection new];
    section.tag = TAG;
    
    section.header = HoloExampleHeaderView.class;
    section.headerModel = @{@"title":@"header"};
    
    section.footer = HoloExampleFooterView.class;
    section.footerModel = @{@"title":@"footer"};
    section.footerHeight = 100;
    
    NSMutableArray *rows = [NSMutableArray new];
    for (NSDictionary *dict in self.modelArray) {
        HoloTableRow *row = [HoloTableRow new];
        row.cell = HoloExampleTableViewCell.class;
        row.model = dict;
        [rows addObject:row];
    }
    section.rows = rows;
    
    self.tableView.holo_sections = @[section];
    [self.tableView reloadData];
}


#pragma mark - Protocol

- (void)makeSectionListByProtocol {
    // Create your own section class confirms to protocol: HoloTableSectionProtocol
    // Create your own row class confirms to protocol: HoloTableRowProtocol
}


#pragma mark - buttonAction

- (void)_addButtonAction:(UIButton *)sender {
    [self insertRowToSectionWithReloadAnimation];
}


#pragma mark - getter

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _addButton.frame = CGRectMake(50, 44, HOLO_SCREEN_WIDTH - 100, 44);
        [_addButton setTitle:@"add a cell" forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(_addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

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

- (NSArray *)modelArray {
    if (!_modelArray) {
        _modelArray = @[
            @{@"bgColor": [UIColor yellowColor],   @"text": @"cell-1", @"height": @66},
            @{@"bgColor": [UIColor cyanColor],     @"text": @"cell-2", @"height": @66},
            @{@"bgColor": [UIColor orangeColor],   @"text": @"cell-3", @"height": @66},
        ];
    }
    return _modelArray;
}

@end
