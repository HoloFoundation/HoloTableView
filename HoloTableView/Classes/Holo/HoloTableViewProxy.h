//
//  HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <Foundation/Foundation.h>
@class HoloRow, HoloSection;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewProxy : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)configCellClsDict:(NSDictionary *)cellDict;

- (HoloSection *)holo_defultSection;

- (HoloSection *)holo_sectionWithTag:(NSString * _Nullable)tag;

- (void)holo_appendSection:(HoloSection *)holoSection;

- (void)holo_replaceSection:(HoloSection *)replaceSection withSection:(HoloSection *)holoSection;

- (void)holo_removeSection:(HoloSection *)holoSection;

- (void)holo_removeAllSection;

- (HoloSection *)holo_sectionWithRowTag:(NSString * _Nullable)tag;

@end

NS_ASSUME_NONNULL_END
