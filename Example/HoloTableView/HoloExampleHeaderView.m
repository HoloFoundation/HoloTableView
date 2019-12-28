//
//  HoloExampleHeaderView.m
//  HoloTableView_Example
//
//  Created by 与佳期 on 2019/8/3.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "HoloExampleHeaderView.h"

@implementation HoloExampleHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        self.textLabel.text = @"header";
    }
    return self;
}

- (void)holo_configureHeaderFooterWithModel:(NSDictionary *)model {
    self.textLabel.text = model[@"title"];
}

+ (CGFloat)holo_heightForHeaderFooterWithModel:(id)model {
    return 100;
}

@end
