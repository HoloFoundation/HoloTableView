//
//  HoloTableViewUpdateRowMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import <Foundation/Foundation.h>
@class HoloRow, HoloSection;

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////
@interface HoloUpdateRow : NSObject

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *cell;

@property (nonatomic, strong) id model;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat estimatedHeight NS_AVAILABLE_IOS(7_0);

@property (nonatomic, assign) SEL configSEL;

@property (nonatomic, assign) SEL heightSEL;

@property (nonatomic, assign) SEL estimatedHeightSEL NS_AVAILABLE_IOS(7_0);

@property (nonatomic, assign) BOOL shouldHighlight NS_AVAILABLE_IOS(6_0);

@end

////////////////////////////////////////////////////////////
@interface HoloUpdateRowMaker : NSObject

@property (nonatomic, strong, readonly) HoloUpdateRow *updateRow;

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^cell)(NSString *cell);

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^model)(id model);

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^height)(CGFloat height);

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^estimatedHeight)(CGFloat estimatedHeight) NS_AVAILABLE_IOS(7_0);

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^configSEL)(SEL configSEL);

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^heightSEL)(SEL heightSEL);

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^estimatedHeightSEL)(SEL estimatedHeightSEL) NS_AVAILABLE_IOS(7_0);

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^shouldHighlight)(BOOL shouldHighlight) NS_AVAILABLE_IOS(6_0);

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewUpdateRowMaker : NSObject

@property (nonatomic, copy, readonly) HoloUpdateRowMaker *(^tag)(NSString *tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloSection *> *)sections;

- (NSArray<NSDictionary *> *)install;

@end

NS_ASSUME_NONNULL_END
