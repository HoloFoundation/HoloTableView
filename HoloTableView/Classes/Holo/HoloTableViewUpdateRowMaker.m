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

@property (nonatomic, strong) HoloRow *targetRow;

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *holoUpdateRows;

@end

@implementation HoloTableViewUpdateRowMaker

- (instancetype)initWithProxyDataSections:(NSArray<HoloSection *> *)sections {
    self = [super init];
    if (self) {
        _holoSections = sections;
    }
    return self;
}

- (HoloUpdateRowMaker *(^)(NSString *))tag {
    return ^id(NSString *tag) {
        HoloUpdateRowMaker *rowMaker = [HoloUpdateRowMaker new];
        HoloRow *updateRow = rowMaker.row;
        updateRow.tag = tag;
        
        NSIndexPath *targetIndexPath;
        HoloSection *targetSection;
        HoloRow *targetRow;
        for (HoloSection *section in self.holoSections) {
            for (HoloRow *row in section.rows) {
                if ([row.tag isEqualToString:tag] || (!row.tag && !tag)) {
                    // set value for CGFloat and BOOL
                    unsigned int outCount;
                    objc_property_t * properties = class_copyPropertyList([row class], &outCount);
                    for (int i = 0; i < outCount; i++) {
                        objc_property_t property = properties[i];
                        const char * propertyAttr = property_getAttributes(property);
                        char t = propertyAttr[1];
                        if (t == 'd' || t == 'B') { // CGFloat or BOOL
                            const char *propertyName = property_getName(property);
                            NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
                            id value = [row valueForKey:propertyNameStr];
                            if (value) [updateRow setValue:value forKey:propertyNameStr];
                        }
                    }
                    // set value for SEL
                    updateRow.configSEL = row.configSEL;
                    updateRow.heightSEL = row.heightSEL;
                    updateRow.estimatedHeightSEL = row.estimatedHeightSEL;
                    
                    targetSection = section;
                    targetRow = row;
                    NSInteger sectionIndex = [self.holoSections indexOfObject:section];
                    NSInteger rowIndex = [section.rows indexOfObject:row];
                    targetIndexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
                    break;
                }
            }
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if (targetRow) {
            dict[@"targetSection"] = targetSection;
            dict[@"targetRow"] = targetRow;
            dict[@"targetIndexPath"] = targetIndexPath;
        }
        dict[@"updateRow"] = updateRow;
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

@end
