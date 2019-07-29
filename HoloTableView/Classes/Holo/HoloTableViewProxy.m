//
//  HoloTableViewProxy.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import "HoloTableViewProxy.h"
#import "HoloTableViewRowMaker.h"
#import "HoloTableViewSectionMaker.h"
#import "HoloTableViewProtocol.h"

@interface HoloTableViewProxy ()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSArray<HoloSection *> *holoSections;

@property (nonatomic, copy) NSDictionary *cellClsDict;

@end

@implementation HoloTableViewProxy

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _holoSections = [NSArray new];
    }
    return self;
}

- (void)configCellClsDict:(NSDictionary *)cellClsDict {
    self.cellClsDict = cellClsDict;
}

- (HoloSection *)holo_defultSection {
    return self.holoSections.firstObject;
}

- (HoloSection *)holo_sectionWithTag:(NSString *)tag {
    for (HoloSection *holoSection in self.holoSections) {
        if ([holoSection.tag isEqualToString:tag] || (!holoSection.tag && !tag)) {
            return holoSection;
        }
    }
    return nil;
}

- (void)holo_appendSection:(HoloSection *)section {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    [array addObject:section];
    self.holoSections = array;
}

- (void)holo_replaceSection:(HoloSection *)replaceSection withSection:(HoloSection *)section {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    NSInteger index = [array indexOfObject:replaceSection];
    [array replaceObjectAtIndex:index withObject:section];
    self.holoSections = array;
}

- (void)holo_removeSection:(HoloSection *)section {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.holoSections];
    [array removeObject:section];
    self.holoSections = array;
}

- (void)holo_removeAllSection {
    self.holoSections = nil;
}

- (HoloSection *)holo_sectionWithRowTag:(NSString *)tag {
    for (HoloSection *holoSection in self.holoSections) {
        for (HoloRow *holoRow in holoSection.holoRows) {
            if ([holoRow.tag isEqualToString:tag] || (!holoRow.tag && !tag)) {
                return holoSection;
            }
        }
    }
    return nil;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.holoSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.holoRows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.holoRows[indexPath.row];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:holoRow.tag forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:holoRow.tag];
    if (!cell) {
        NSString *clsName = self.cellClsDict[holoRow.cell];
        Class cls = clsName ? NSClassFromString(clsName) : NSClassFromString(holoRow.cell);
        cell = [[cls alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:holoRow.tag];
    }
    
    if (holoRow.configSEL && [cell respondsToSelector:holoRow.configSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cell performSelector:holoRow.configSEL withObject:holoRow.model];
#pragma clang diagnostic pop
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:holoRow.tag];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.holoRows[indexPath.row];
    
    NSString *clsName = self.cellClsDict[holoRow.cell];
    Class cls = clsName ? NSClassFromString(clsName) : NSClassFromString(holoRow.cell);
    if ([cls conformsToProtocol:@protocol(HoloTableViewProtocol)] && holoRow.heightSEL && [cls respondsToSelector:holoRow.heightSEL]) {
        CGFloat cellHeight = [cls heightForRow:holoRow.model];
        return cellHeight;
    }
    
    return holoRow.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.holoRows[indexPath.row];
    if (holoRow.didSelectHandler) holoRow.didSelectHandler(holoRow.model);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.holoRows[indexPath.row];
    if (holoRow.willDisplayHandler) holoRow.willDisplayHandler(cell);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section >= self.holoSections.count) return;
    
    HoloSection *holoSection = self.holoSections[indexPath.section];
    HoloRow *holoRow = holoSection.holoRows[indexPath.row];
    if (holoRow.didEndDisplayHandler) holoRow.didEndDisplayHandler(cell);
}

#pragma mark - UITableViewDelegate (header and footer)
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.headerViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    HoloSection *holoSection = self.holoSections[section];
    return holoSection.footerViewHeight;
}

@end
