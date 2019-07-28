//
//  UITableView+HoloTableView.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "UITableView+HoloTableView.h"
#import "UITableView+HoloTableViewProxy.h"
#import "HoloTableViewProxy.h"
#import "HoloTableViewMaker.h"
#import "HoloSection.h"
#import "HoloTableViewConfiger.h"

@implementation UITableView (HoloTableView)

- (void)holo_configTableView:(void(^)(HoloTableViewConfiger *configer))block {
    HoloTableViewConfiger *configer = [HoloTableViewConfiger new];
    if (block) block(configer);
    NSDictionary *cellClsDict = [configer install];
    [self.holoTableViewProxy configCellClsDict:cellClsDict];
}

- (void)holo_makeSection:(void (^)(HoloTableViewMaker * _Nonnull))block {
    HoloTableViewMaker *maker = [HoloTableViewMaker new];
    if (block) block(maker);
    
    HoloSection *appendSection = [maker install];
    HoloSection *holoSection = [self.holoTableViewProxy holo_sectionWithTag:appendSection.tag];
    if (holoSection) {
        if (appendSection.headerView) {
            holoSection.headerView = appendSection.headerView;
            holoSection.headerViewHeight = appendSection.headerViewHeight;
        }
        if (appendSection.footerView) {
            holoSection.footerView = appendSection.footerView;
            holoSection.footerViewHeight = appendSection.footerViewHeight;
        }
        if (appendSection.holoRows.count > 0) {
            [holoSection holo_appendRows:appendSection.holoRows];
        }
    } else {
        [self.holoTableViewProxy holo_appendSection:appendSection];
    }
}

- (void)holo_updateSection:(void (^)(HoloTableViewMaker * _Nonnull))block {
    HoloTableViewMaker *maker = [HoloTableViewMaker new];
    if (block) block(maker);
    
    HoloSection *appendSection = [maker install];
    HoloSection *holoSection = [self.holoTableViewProxy holo_sectionWithTag:appendSection.tag];
    if (holoSection) {
        if (appendSection.headerView) {
            holoSection.headerView = appendSection.headerView;
            holoSection.headerViewHeight = appendSection.headerViewHeight;
        }
        if (appendSection.footerView) {
            holoSection.footerView = appendSection.footerView;
            holoSection.footerViewHeight = appendSection.footerViewHeight;
        }
        if (appendSection.holoRows.count > 0) {
            [holoSection holo_deleteAllRows];
            [holoSection holo_appendRows:appendSection.holoRows];
        }
    }
}

- (void)holo_deleteSection:(void (^)(HoloTableViewMaker * _Nonnull))block {
    HoloTableViewMaker *maker = [HoloTableViewMaker new];
    if (block) block(maker);
    
    HoloSection *deleteSection = [maker install];
    if (!deleteSection.tag) {
        [self.holoTableViewProxy holo_deleteAllSection];
    } else {
        HoloSection *holoSection = [self.holoTableViewProxy holo_sectionWithTag:deleteSection.tag];
        if (holoSection) {
            [self.holoTableViewProxy holo_deleteSection:holoSection];
        }
    }
}

@end
