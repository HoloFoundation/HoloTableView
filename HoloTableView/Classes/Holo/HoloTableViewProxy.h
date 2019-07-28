//
//  HoloTableViewProxy.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/27.
//

#import <Foundation/Foundation.h>
@class HoloSection;

NS_ASSUME_NONNULL_BEGIN

@interface HoloTableViewProxy : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)configCellClsDict:(NSDictionary *)cellDict;

- (HoloSection *)holo_defultSection;

- (HoloSection *)holo_sectionWithTag:(NSString *)tag;

- (void)holo_appendSection:(HoloSection *)holoSection;

- (void)holo_deleteSection:(HoloSection *)holoSection;

- (void)holo_deleteAllSection;

@end

NS_ASSUME_NONNULL_END
