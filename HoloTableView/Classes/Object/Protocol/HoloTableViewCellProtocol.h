//
//  HoloTableViewCellProtocol.h
//  HoloTableView
//
//  Created by 与佳期 on 2020/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HoloTableViewCellProtocol <NSObject>

@required

/**
 *  Your cell must implement this method in order for the HoloTableView to pass the externally-set model to the current cell.
 */
- (void)holo_configureCellWithModel:(id _Nullable)model;


@optional

/**
 *  If your cell implements this method, the HolotableView will set the height of the current cell from the return value of this method.
 *
 *  Note that if your cell implements this method, the `heightHandler` and `height` properties set externally will be invalidated.
 */
+ (CGFloat)holo_heightForCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, the HolotableView will set the estimated height of the current cell from the return value of this method.
 *
 *  Note that if your cell implements this method, the `estimatedHeightHandler` and `estimatedHeight` properties set externally will be invalidated.
 */
+ (CGFloat)holo_estimatedHeightForCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, the HolotableView will set the should highlight or not of the current cell from the return value of this method.
 *
 *  Note that if your cell implements this method, the `shouldHighlightHandler` and `shouldHighlight` properties set externally will be invalidated.
 */
- (BOOL)holo_shouldHighlightForCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell will select.
 *
 *  Note that if your cell implements this method, the `willSelectHandler` property set externally will be invalidated.
 */
- (void)holo_willSelectCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell will deselect.
 *
 *  Note that if your cell implements this method, the `willDeselectHandler` property set externally will be invalidated.
 */
- (void)holo_willDeselectCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell did deselect.
 *
 *  Note that if your cell implements this method, the `didDeselectHandler` property set externally will be invalidated.
 */
- (void)holo_didDeselectCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell did select.
 *
 *  Note that if your cell implements this method, the `didSelectHandler` property set externally will be invalidated.
 */
- (void)holo_didSelectCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell will display.
 *
 *  Note that if your cell implements this method, the `willDisplayHandler` property set externally will be invalidated.
 */
- (void)holo_willDisplayCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell did end displaying.
 *
 *  Note that if your cell implements this method, the `didEndDisplayingHandler` property set externally will be invalidated.
 */
- (void)holo_didEndDisplayingCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell did highlight.
 *
 *  Note that if your cell implements this method, the `didHighlightHandler` property set externally will be invalidated.
 */
- (void)holo_didHighlightCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell did un highlight.
 *
 *  Note that if your cell implements this method, the `didUnHighlightHandler` property set externally will be invalidated.
 */
- (void)holo_didUnHighlightCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell accessory button tapped.
 *
 *  Note that if your cell implements this method, the `accessoryButtonTappedHandler` property set externally will be invalidated.
 */
- (void)holo_accessoryButtonTappedCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell will begin editing.
 *
 *  Note that if your cell implements this method, the `willBeginEditingHandler` property set externally will be invalidated.
 */
- (void)holo_willBeginEditingCellWithModel:(id _Nullable)model;

/**
 *  If your cell implements this method, this method will be called when the cell did end editing.
 *
 *  Note that if your cell implements this method, the `didEndEditingHandler` property set externally will be invalidated.
 */
- (void)holo_didEndEditingCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
