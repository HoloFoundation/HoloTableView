//
//  HoloTableViewUpdateRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/29.
//

#import "HoloTableViewUpdateRowMaker.h"
#import <objc/runtime.h>
#import "HoloTableViewSectionMaker.h"

////////////////////////////////////////////////////////////
@implementation HoloUpdateRowMaker

- (HoloUpdateRowMaker * (^)(NSString *))cell {
    return ^id(NSString *cell){
        self.row.cell = cell;
        return self;
    };
}

@end

////////////////////////////////////////////////////////////
@interface HoloTableViewUpdateRowMaker ()

@property (nonatomic, copy) NSArray<HoloSection *> *holoSections;

@property (nonatomic, assign) BOOL isRemark;

@property (nonatomic, strong) HoloRow *targetRow;

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *holoUpdateRows;

@property (nonatomic, strong) NSMutableDictionary *rowIndexPathsDict;

@end

@implementation HoloTableViewUpdateRowMaker

- (instancetype)initWithProxyDataSections:(NSArray<HoloSection *> *)sections isRemark:(BOOL)isRemark {
    self = [super init];
    if (self) {
        _holoSections = sections;
        _isRemark = isRemark;
        
        for (HoloSection *section in self.holoSections) {
            for (HoloRow *row in section.rows) {
                NSString *dictKey = row.tag ?: HOLO_ROW_TAG_NIL;
                if (self.rowIndexPathsDict[dictKey]) continue;
                
                NSMutableDictionary *dict = @{HOLO_TARGET_ROW : row}.mutableCopy;
                NSInteger sectionIndex = [self.holoSections indexOfObject:section];
                NSInteger rowIndex = [section.rows indexOfObject:row];
                dict[HOLO_TARGET_INDEXPATH] = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
                self.rowIndexPathsDict[dictKey] = [dict copy];
            }
        }
    }
    return self;
}

- (HoloUpdateRowMaker *(^)(NSString *))tag {
    return ^id(NSString *tag) {
        HoloUpdateRowMaker *rowMaker = [HoloUpdateRowMaker new];
        HoloRow *updateRow = rowMaker.row;
        updateRow.tag = tag;
        
        NSString *dictKey = tag ?: HOLO_ROW_TAG_NIL;
        NSDictionary *rowIndexPathDict = self.rowIndexPathsDict[dictKey];
        
        NSIndexPath *targetIndexPath = rowIndexPathDict[HOLO_TARGET_INDEXPATH];
        HoloRow *targetRow = rowIndexPathDict[HOLO_TARGET_ROW];
        if (!self.isRemark && targetRow) {
            // set value of CGFloat and BOOL
            unsigned int outCount;
            objc_property_t * properties = class_copyPropertyList([targetRow class], &outCount);
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                const char * propertyAttr = property_getAttributes(property);
                char t = propertyAttr[1];
                if (t == 'd' || t == 'B') { // CGFloat or BOOL
                    const char *propertyName = property_getName(property);
                    NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
                    id value = [targetRow valueForKey:propertyNameStr];
                    if (value) [updateRow setValue:value forKey:propertyNameStr];
                }
            }
            // set value of SEL
            updateRow.configSEL = targetRow.configSEL;
            updateRow.heightSEL = targetRow.heightSEL;
            updateRow.estimatedHeightSEL = targetRow.estimatedHeightSEL;
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (targetRow) {
            dict[HOLO_TARGET_ROW] = targetRow;
            dict[HOLO_TARGET_INDEXPATH] = targetIndexPath;
        }
        dict[HOLO_UPDATE_ROW] = updateRow;
        [self.holoUpdateRows addObject:dict];
        
        return rowMaker;
    };
}

- (NSArray<NSDictionary *> *)install {
    return [self.holoUpdateRows copy];
}

#pragma mark - getter
- (NSMutableArray<NSDictionary *> *)holoUpdateRows {
    if (!_holoUpdateRows) {
        _holoUpdateRows = [NSMutableArray new];
    }
    return _holoUpdateRows;
}

- (NSMutableDictionary *)rowIndexPathsDict {
    if (!_rowIndexPathsDict) {
        _rowIndexPathsDict = [NSMutableDictionary new];
    }
    return _rowIndexPathsDict;
}

@end
