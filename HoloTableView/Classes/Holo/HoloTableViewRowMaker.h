//
//  HoloTableViewRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@interface HoloRow : NSObject

@property (nonatomic, copy) NSString *cell;

@property (nonatomic, strong) id model;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat estimatedHeight;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) SEL configSEL;

@property (nonatomic, assign) SEL heightSEL;

@property (nonatomic, assign) SEL estimatedHeightSEL;

@property (nonatomic, assign) BOOL shouldHighlight;

@property (nonatomic, copy) void (^willSelectHandler)(id model);

@property (nonatomic, copy) void (^willDeselectHandler)(id model);

@property (nonatomic, copy) void (^didDeselectHandler)(id model);

@property (nonatomic, copy) void (^didSelectHandler)(id model);

@property (nonatomic, copy) void (^willDisplayHandler)(UITableViewCell *cell);

@property (nonatomic, copy) void (^didEndDisplayingHandler)(UITableViewCell *cell);

@property (nonatomic, copy) void (^didHighlightHandler)(id model);

@property (nonatomic, copy) void (^didUnHighlightHandler)(id model);

@end

////////////////////////////////////////////////////////////
@interface HoloRowMaker : NSObject

@property (nonatomic, strong, readonly) HoloRow *row;

@property (nonatomic, copy, readonly) HoloRowMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloRowMaker *(^height)(CGFloat height);

@property (nonatomic, copy, readonly) HoloRowMaker *(^estimatedHeight)(CGFloat estimatedHeight);

@property (nonatomic, copy, readonly) HoloRowMaker *(^tag)(NSString *tag);

@property (nonatomic, copy, readonly) HoloRowMaker *(^configSEL)(SEL configSEL);

@property (nonatomic, copy, readonly) HoloRowMaker *(^heightSEL)(SEL heightSEL);

@property (nonatomic, copy, readonly) HoloRowMaker *(^estimatedHeightSEL)(SEL estimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloRowMaker *(^shouldHighlight)(BOOL shouldHighlight);

@property (nonatomic, copy, readonly) HoloRowMaker *(^willSelectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^willDeselectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didDeselectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didSelectHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^willDisplayHandler)(void(^)(UITableViewCell *cell));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didEndDisplayingHandler)(void(^)(UITableViewCell *cell));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didHighlightHandler)(void(^)(id model));

@property (nonatomic, copy, readonly) HoloRowMaker *(^didUnHighlightHandler)(void(^)(id model));

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloRowMaker *(^row)(NSString *rowName);

- (NSArray<HoloRow *> *)install;

@end

NS_ASSUME_NONNULL_END
