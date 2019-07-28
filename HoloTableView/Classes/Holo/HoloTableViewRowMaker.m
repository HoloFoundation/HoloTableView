//
//  HoloTableViewRowMaker.m
//  HoloTableView
//
//  Created by 与佳期 on 2019/7/28.
//

#import "HoloTableViewRowMaker.h"
#import "HoloRow.h"

@implementation HoloTableViewRowMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _row = [HoloRow new];
    }
    return self;
}

- (HoloTableViewRowMaker *(^)(id))model {
    return ^id(id model){
        self.row.model = model;
        return self;
    };
}

- (HoloTableViewRowMaker *(^)(CGFloat))height {
    return ^id(CGFloat height){
        self.row.height = height;
        return self;
    };
}

- (HoloTableViewRowMaker *(^)(NSString *))tag {
    return ^id(NSString *tag){
        self.row.tag = tag;
        return self;
    };
}

- (HoloTableViewRowMaker * (^)(void (^)(id)))didSelectHandler {
    return ^id( void (^didSelectHandler)(id) ){
        self.row.didSelectHandler = didSelectHandler;
        return self;
    };
}

- (HoloTableViewRowMaker *(^)(void (^)(UITableViewCell *)))willDisplayHandler {
    return ^id( void (^willDisplayHandler)(UITableViewCell *cell) ){
        self.row.willDisplayHandler = willDisplayHandler;
        return self;
    };
}

- (HoloTableViewRowMaker *(^)(void (^)(UITableViewCell *)))didEndDisplayHandler {
    return ^id( void (^didEndDisplayHandler)(UITableViewCell *cell) ){
        self.row.didEndDisplayHandler = didEndDisplayHandler;
        return self;
    };
}

@end
