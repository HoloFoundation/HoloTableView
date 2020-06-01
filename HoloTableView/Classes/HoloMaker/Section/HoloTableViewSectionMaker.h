//
//  HoloTableViewSectionMaker.h
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import <Foundation/Foundation.h>
@class HoloTableSection, HoloTableSectionMaker;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HoloTableViewSectionMakerType) {
    HoloTableViewSectionMakerTypeMake,
    HoloTableViewSectionMakerTypeInsert,
    HoloTableViewSectionMakerTypeUpdate,
    HoloTableViewSectionMakerTypeRemake
};


@interface HoloTableViewSectionMakerModel : NSObject

@property (nonatomic, strong) HoloTableSection *operateSection;

@property (nonatomic, strong) NSNumber *operateIndex;

@end


@interface HoloTableViewSectionMaker : NSObject

@property (nonatomic, copy, readonly) HoloTableSectionMaker *(^section)(NSString *tag);

- (instancetype)initWithProxyDataSections:(NSArray<HoloTableSection *> *)sections
                                makerType:(HoloTableViewSectionMakerType)makerType;

- (NSArray<HoloTableViewSectionMakerModel *> *)install;

@end

NS_ASSUME_NONNULL_END
