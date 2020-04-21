//
//  HoloTableViewSectionMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloTableRow, HoloTableViewRowMaker;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HoloTableViewSectionMakerType) {
    HoloTableViewSectionMakerTypeMake,
    HoloTableViewSectionMakerTypeInsert,
    HoloTableViewSectionMakerTypeUpdate,
    HoloTableViewSectionMakerTypeRemake
};

////////////////////////////////////////////////////////////
@interface HoloTableSection : NSObject

@property (nonatomic, copy, nullable) NSArray<HoloTableRow *> *rows;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *footer;

@property (nonatomic, strong) id headerModel;

@property (nonatomic, strong) id footerModel;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, assign) CGFloat headerEstimatedHeight;

@property (nonatomic, assign) CGFloat footerEstimatedHeight;

@property (nonatomic, assign) SEL headerFooterConfigSEL;

@property (nonatomic, assign) SEL headerFooterHeightSEL;

@property (nonatomic, assign) SEL headerFooterEstimatedHeightSEL;

@property (nonatomic, copy) void (^willDisplayHeaderHandler)(UIView *header, id _Nullable model);

@property (nonatomic, copy) void (^willDisplayFooterHandler)(UIView *footer, id _Nullable model);

@property (nonatomic, copy) void (^didEndDisplayingHeaderHandler)(UIView *header, id _Nullable model);

@property (nonatomic, copy) void (^didEndDisplayingFooterHandler)(UIView *footer, id _Nullable model);

- (NSIndexSet *)insertRows:(NSArray<HoloTableRow *> *)rows atIndex:(NSInteger)index;

- (void)removeRow:(HoloTableRow *)row;

- (void)removeAllRows;

@end

////////////////////////////////////////////////////////////
@interface HoloTableSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^header)(Class header);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footer)(Class footer);
// header string
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerS)(NSString *headerS);
// footer string
@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerS)(NSString *footerS);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerModel)(id headerModel);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerModel)(id footerModel);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerHeight)(CGFloat headerHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerHeight)(CGFloat footerHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerEstimatedHeight)(CGFloat headerEstimatedHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^footerEstimatedHeight)(CGFloat footerEstimatedHeight);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterConfigSEL)(SEL headerConfigSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterHeightSEL)(SEL headerHeightSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^headerFooterEstimatedHeightSEL)(SEL headerEstimatedHeightSEL);

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayHeaderHandler)(void(^)(UIView *header, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^willDisplayFooterHandler)(void(^)(UIView *footer, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingHeaderHandler)(void(^)(UIView *header, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^didEndDisplayingFooterHandler)(void(^)(UIView *footer, id _Nullable model));

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^makeRows)(void(NS_NOESCAPE ^)(HoloTableViewRowMaker *make));

@end


////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMakerModel : NSObject

@property (nonatomic, strong) HoloTableSection *operateSection;

@property (nonatomic, strong) NSNumber *operateIndex;

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^section)(NSString *tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections makerType:(HoloTableViewSectionMakerType)makerType;

- (NSArray<HoloTableViewSectionMakerModel *> *)install;

@end

NS_ASSUME_NONNULL_END
