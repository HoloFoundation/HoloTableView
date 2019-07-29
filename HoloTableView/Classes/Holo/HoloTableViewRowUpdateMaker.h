//
//  HoloTableViewRowUpdateMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//============================================================:HoloUpdateRow
@interface HoloUpdateRow : NSObject

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *cell;

@property (nonatomic, strong) id model;

@property (nonatomic, assign) CGFloat height;

@end

//============================================================:HoloRowUpdateMaker
@interface HoloRowUpdateMaker : NSObject

@property (nonatomic, strong, readonly) HoloUpdateRow *updateRow;

@property (nonatomic, copy, readonly) HoloRowUpdateMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloRowUpdateMaker *(^height)(CGFloat height);

@end

//============================================================:HoloTableViewRowUpdateMaker
@interface HoloTableViewRowUpdateMaker : NSObject

@property (nonatomic, copy, readonly) HoloRowUpdateMaker *(^tag)(NSString *tag);

- (NSArray<HoloUpdateRow *> *)install;

@end

NS_ASSUME_NONNULL_END
