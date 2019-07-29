//
//  HoloTableViewRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//============================================================:HoloRow
@interface HoloRow : NSObject

@property (nonatomic, copy) NSString *cell;

@property (nonatomic, strong) id model;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) SEL configSEL;

@property (nonatomic, assign) SEL heightSEL;

@property (nonatomic, copy) void (^didSelectHandler)(id);

@property (nonatomic, copy) void (^willDisplayHandler)(UITableViewCell *cell);

@property (nonatomic, copy) void (^didEndDisplayingHandler)(UITableViewCell *cell);

@end

//============================================================:HoloRowMaker
@interface HoloRowMaker : NSObject

@property (nonatomic, strong, readonly) HoloRow *row;

@property (nonatomic, copy, readonly) HoloRowMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloRowMaker *(^height)(CGFloat height);

@property (nonatomic, copy, readonly) HoloRowMaker *(^tag)(NSString *tag);

@property (nonatomic, copy, readonly) HoloRowMaker *(^didSelectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^willDisplayHandler)(void(^)(UITableViewCell *cell));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didEndDisplayingHandler)(void(^)(UITableViewCell *cell));

@end

//============================================================:HoloTableViewRowMaker
@interface HoloTableViewRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloRowMaker *(^row)(NSString *rowName);

- (NSArray<HoloRow *> *)install;

@end

NS_ASSUME_NONNULL_END
