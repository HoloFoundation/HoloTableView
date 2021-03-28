//
//  HoloTableViewHeaderProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewHeaderProtocol <NSObject>

@required

/**
 *  Your section header must implement this method in order for the HoloTableView to pass the externally-set model to the current section header.
 */
- (void)holo_configureHeaderWithModel:(id _Nullable)model;


@optional

/**
 *  If your section header implements this method, the HolotableView will set the height of the current section header from the return value of this method.
 *
 *  Note that if your section header implements this method, the `headerHeightHandler` and `headerHeight` properties set externally will be invalidated.
 */
+ (CGFloat)holo_heightForHeaderWithModel:(id _Nullable)model;

/**
 *  If your section header implements this method, the HolotableView will set the estimated height of the current section header from the return value of this method.
 *
 *  Note that if your section header implements this method, the `estimatedHeaderHeightHandler` and `estimatedHeaderHeight` properties set externally will be invalidated.
 */
+ (CGFloat)holo_estimatedHeightForHeaderWithModel:(id _Nullable)model;

/**
 *  If your section header implements this method, this method will be called when the section header will display.
 *
 *  Note that if your section header implements this method, the `willDisplayHandler` property set externally will be invalidated.
 */
- (void)holo_willDisplayHeaderWithModel:(id _Nullable)model;

/**
 *  If your section header implements this method, this method will be called when the section header did end displaying.
 *
 *  Note that if your section header implements this method, the `didEndDisplayingHandler` property set externally will be invalidated.
 */
- (void)holo_didEndDisplayingHeaderWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
