//
//  HoloTableViewFooterProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewFooterProtocol <NSObject>

@required

/**
 *  Your section footer must implement this method in order for the HoloTableView to pass the externally-set model to the current section footer.
 */
- (void)holo_configureFooterWithModel:(id _Nullable)model;


@optional

/**
 *  If your section footer implements this method, the HolotableView will set the height of the current section footer from the return value of this method.
 *
 *  Note that if your section footer implements this method, the `footerHeightHandler` and `footerHeight` properties set externally will be invalidated.
 */
+ (CGFloat)holo_heightForFooterWithModel:(id _Nullable)model;

/**
 *  If your section footer implements this method, the HolotableView will set the estimated height of the current section footer from the return value of this method.
 *
 *  Note that if your section footer implements this method, the `estimatedFooterHeightHandler` and `estimatedFooterHeight` properties set externally will be invalidated.
 */
+ (CGFloat)holo_estimatedHeightForFooterWithModel:(id _Nullable)model;

/**
 *  If your section footer implements this method, this method will be called when the section footer will display.
 *
 *  Note that if your section footer implements this method, the `willDisplayHandler` property set externally will be invalidated.
 */
- (void)holo_willDisplayFooterWithModel:(id _Nullable)model;

/**
 *  If your section footer implements this method, this method will be called when the section footer did end displaying.
 *
 *  Note that if your section footer implements this method, the `didEndDisplayingHandler` property set externally will be invalidated.
 */
- (void)holo_didEndDisplayingFooterWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
