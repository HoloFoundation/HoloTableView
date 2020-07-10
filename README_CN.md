# HoloTableView（中文使用说明）



## 1、常见用法：创建 cell 列表

参见 [HoloTableViewRowMaker.h](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/HoloMaker/Row/HoloTableViewRowMaker.h) 及 [HoloTableRowMaker.h](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/HoloMaker/Row/HoloTableRowMaker.h)

```objc
UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
[self.view addSubview:tableView];

[tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
   // make a cell
   make.row(ExampleTableViewCell.class).model(NSDictionary.new).height(44);
   
   // make a list
   for (NSObject *obj in NSArray.new) {
       make.row(ExampleTableViewCell.class).model(obj).didSelectHandler(^(id  _Nullable model) {
           NSLog(@"did select row : %@", model);
       });
   }
}];

[self.tableView reloadData];
```



### 对 Cell 的要求

参见：[HoloTableViewCellProtocol](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/Holo/HoloProtocol/HoloTableViewCellProtocol.h)

遵守 HoloTableViewCellProtocol 协议，选择实现其中的方法，常用的两个方法：

```objc
@required;

// 给 cell 赋值 model
- (void)holo_configureCellWithModel:(id)model;


@optional

// 返回 cell 的高度（优先于 make 配置的 heightHandler 属性及 height 属性使用）
+ (CGFloat)holo_heightForCellWithModel:(id)model;
```





## 2、常见用法：创建 section 列表，包含 header、footer、row列表



参见 [HoloTableViewSectionMaker.h](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/HoloMaker/Section/HoloTableViewSectionMaker.h) 及  [HoloTableSectionMaker.h](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/HoloMaker/Section/HoloTableSectionMaker.h) 

```objc
UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
[self.view addSubview:tableView];
    
[self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
    make.section(TAG)
    .header(ExampleHeaderView.class)
    .headerModel(NSDictionary.new)
    .footer(ExampleFooterView.class)
    .footerModel(NSDictionary.new)
    .makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
        // make a cell
        make.row(ExampleTableViewCell.class).model(NSDictionary.new).height(44);
        
        // make a list
        for (NSObject *obj in NSArray.new) {
            make.row(ExampleTableViewCell.class).model(obj).didSelectHandler(^(id  _Nullable model) {
                NSLog(@"did select row : %@", model);
            });
        }
    });
}];
    
[self.tableView reloadData];
```



### 对 header、footer 的要求

参见：[HoloTableViewHeaderProtocol](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/Holo/HoloProtocol/HoloTableViewHeaderProtocol.h) 及 [HoloTableViewFooterProtocol](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/Holo/HoloProtocol/HoloTableViewFooterProtocol.h)

1、header： 遵守 HoloTableViewHeaderProtocol 协议，选择实现其中的方法，常用的两个方法：

```objc
@required;

// 给 header 赋值 model
- (void)holo_configureHeaderWithModel:(id)model;


@optional
  
// 返回 header 的高度（优先于 make 配置的 headerHeightHandler 属性及 headerHeight 属性使用）
+ (CGFloat)holo_heightForHeaderWithModel:(id)model;
```



2、Footer：遵守 HoloTableViewFooterProtocol 协议，选择实现其中的方法，常用的两个方法：

```objc
@required;

// 给 header 赋值 model
- (void)holo_configureFooterWithModel:(id)model;


@optional

// 返回 header 的高度（优先于 make 配置的 headerHeightHandler 属性及 headerHeight 属性使用）
+ (CGFloat)holo_heightForFooterWithModel:(id)model;
```





## 3、section 的增删改

参见：[UITableView+HoloTableView.h (section 部分)](https://github.com/HoloFoundation/HoloTableView/blob/faf89c1dc5d6403b02b9d9d80604622c703d98cf/HoloTableView/Classes/Holo/UITableView%2BHoloTableView.h#L24-L144)

```objc
// 创建 section
[self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
    make.section(TAG);
}];

// 在指定位置创建 section
[self.tableView holo_insertSectionsAtIndex:0 block:^(HoloTableViewSectionMaker * _Nonnull make) {
    make.section(TAG);
}];

// 更新 section，根据 tag 值匹配 section 更新给定的属性
[self.tableView holo_updateSections:^(HoloTableViewSectionMaker * _Nonnull make) {
    make.section(TAG);
}];

// 重置 section，根据 tag 值匹配 cell，将原有属性清空，赋值新的属性
[self.tableView holo_remakeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
    make.section(TAG);
}];

// 删除所有 section
[self.tableView holo_removeAllSections];

// 根据 tag 值匹配 section 删除
[self.tableView holo_removeSections:@[TAG]];

[self.tableView reloadData];
```





## 4、cell 的增删改

参见：[UITableView+HoloTableView.h (row 部分)](https://github.com/HoloFoundation/HoloTableView/blob/faf89c1dc5d6403b02b9d9d80604622c703d98cf/HoloTableView/Classes/Holo/UITableView%2BHoloTableView.h#L146-L328)

```objc
// 为 tag 为 nil 的 section 创建 row
[self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
    make.row(HoloExampleTableViewCell.class);
}];

// 为指定 tag 的 section 创建 row
[self.tableView holo_makeRowsInSection:TAG block:^(HoloTableViewRowMaker * _Nonnull make) {
    make.row(HoloExampleTableViewCell.class);
}];

// 为 tag 为 nil 的 section，在指定位置插入 row
[self.tableView holo_insertRowsAtIndex:0 block:^(HoloTableViewRowMaker * _Nonnull make) {
    make.row(HoloExampleTableViewCell.class);
}];

// 为指定 tag 的 section，在指定位置插入 row
[self.tableView holo_insertRowsAtIndex:0 inSection:TAG block:^(HoloTableViewRowMaker * _Nonnull make) {
    make.row(HoloExampleTableViewCell.class);
}];

// 更新 row，根据 tag 值匹配 cell 更新给定的属性
[self.tableView holo_updateRows:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
    make.tag(TAG).height(120);
}];

// 重置 row，根据 tag 值匹配 cell，将原有属性清空，赋值新的属性
[self.tableView holo_remakeRows:^(HoloTableViewUpdateRowMaker * _Nonnull make) {
    make.tag(TAG).model(NSDictionary.new).height(120);
}];

// 根据 tag 值匹配 section，将其中的 row 清空
[self.tableView holo_removeAllRowsInSections:@[TAG]];
// 根据 tag 值匹配 row 删除
[self.tableView holo_removeRows:@[TAG]];

[self.tableView reloadData];
```



## 5、全量用法：创建 section，设置 header、footer、row

参见 [HoloTableViewSectionMaker.h](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/HoloMaker/Section/HoloTableViewSectionMaker.h) 及  [HoloTableSectionMaker.h](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/HoloMaker/Section/HoloTableSectionMaker.h) 



```objc
[self.tableView holo_makeSections:^(HoloTableViewSectionMaker * _Nonnull make) {
    // #1、给 section 标识 tag 返回 HoloTableSectionMaker 对象
    make.section(TAG)
    
    // #2、配置 header
    // header 类
    .header(ExampleHeaderView.class)
    // header model 数据
    .headerModel(NSObject.new)
    // header 复用标识
    .headerReuseId(@"reuseIdentifier")
    // header 高度
    .headerHeight(101)
    // header 估算高度
    .headerEstimatedHeight(100)
    // 返回 header model，实现该 block 的话。注意：优先于 headerModel 属性
    .headerModelHandler(^id _Nonnull(id  _Nullable model) {
        return NSObject.new;
    })
    // 返回 header 复用标识，实现该 block 的话，优先于 headerReuseId 属性
    .headerReuseIdHandler(^NSString * _Nonnull(id  _Nullable model) {
        return (@"reuseIdentifier");
    })
    // 返回 header 高度，实现该 block 的话。注意：优先于 headerHeight 属性
    .headerHeightHandler(^CGFloat(id  _Nullable model) {
        return 101;
    })
    // 返回 header 估算高度，实现该 block 的话。注意：优先于 headerEstimatedHeight 属性
    .headerEstimatedHeightHandler(^CGFloat(id  _Nullable model) {
        return 100;
    })
    // header 即将出现
    .willDisplayHeaderHandler(^(UIView * _Nonnull header, id  _Nullable model) {
        NSLog(@"will display header ");
    })
    // header 已经出现
    .didEndDisplayingHeaderHandler(^(UIView * _Nonnull header, id  _Nullable model) {
        NSLog(@"did end display header ");
    })
    // 以下是 header 默认调用方法，建议 header 遵守 HoloTableViewHeaderProtocol，实现如下方法
    // header 赋值 model 调用的方法
    .headerConfigSEL(@selector(holo_configureHeaderWithModel:))
    // header 返回高度调用的方法，header 实现该方法的话。注意：优先于 headerHeightHandler 属性及 headerHeight 属性
    .headerHeightSEL(@selector(holo_heightForHeaderWithModel:))
    // header 返回估算高度调用的方法，header 实现该方法的话。注意：优先于 headerEstimatedHeightHandler 属性及 headerEstimatedHeight 属性
    .headerEstimatedHeightSEL(@selector(holo_estimatedHeightForHeaderWithModel:))
    // header 即将出现调用的方法，header 实现该方法的话。注意：优先于 willDisplayHeaderHandler 属性
    .willDisplayHeaderSEL(@selector(holo_willDisplayHeaderWithModel:))
    // header 已经出现调用的方法，header 实现该方法的话。注意：优先于 didEndDisplayingHeaderHandler 属性
    .didEndDisplayingHeaderSEL(@selector(holo_didEndDisplayingHeaderWithModel:))
    
    // #3、配置 footer
    // footer 类
    .footer(HoloExampleFooterView.class)
    // footer model 数据
    .footerModel(NSObject.new)
    // footer 复用标识
    .footerReuseId(@"reuseIdentifier")
    // footer 高度
    .footerHeight(101)
    // footer 估算高度
    .footerEstimatedHeight(100)
    // 返回 footer model，实现该 block 的话。注意：优先于 footerModel 属性
    .footerModelHandler(^id _Nonnull(id  _Nullable model) {
        return NSObject.new;
    })
    // 返回 footer 复用标识，实现该 block 的话，优先于 footerReuseId 属性
    .footerReuseIdHandler(^NSString * _Nonnull(id  _Nullable model) {
        return (@"reuseIdentifier");
    })
    // 返回 footer 高度，实现该 block 的话。注意：优先于 footerHeight 属性
    .footerHeightHandler(^CGFloat(id  _Nullable model) {
        return 101;
    })
    // 返回 footer 估算高度，实现该 block 的话。注意：优先于 footerEstimatedHeight 属性
    .footerEstimatedHeightHandler(^CGFloat(id  _Nullable model) {
        return 100;
    })
    // header 即将出现
    .willDisplayFooterHandler(^(UIView * _Nonnull footer, id  _Nullable model) {
        NSLog(@"will display footer ");
    })
    // footer 已经出现
    .didEndDisplayingFooterHandler(^(UIView * _Nonnull footer, id  _Nullable model) {
        NSLog(@"did end display footer ");
    })
    // 以下是 footer 默认调用方法，建议 footer 遵守 HoloTableViewFooterProtocol，实现如下方法
    // footer 赋值 model 调用的方法
    .footerConfigSEL(@selector(holo_configureFooterWithModel:))
    // footer 返回高度调用的方法，footer 实现该方法的话。注意：优先于 footerHeightHandler 属性及 footerHeight 属性
    .footerHeightSEL(@selector(holo_heightForFooterWithModel:))
    // footer 返回估算高度调用的方法，footer 实现该方法的话。注意：优先于 footerEstimatedHeightHandler 属性及 footerEstimatedHeight 属性
    .footerEstimatedHeightSEL(@selector(holo_estimatedHeightForFooterWithModel:))
    // footer 即将出现调用的方法，footer 实现该方法的话。注意：优先于 willDisplayFooterHandler 属性
    .willDisplayFooterSEL(@selector(holo_willDisplayFooterWithModel:))
    // footer 已经出现调用的方法，footer 实现该方法的话。注意：优先于 didEndDisplayingFooterHandler 属性
    .didEndDisplayingFooterSEL(@selector(holo_didEndDisplayingFooterWithModel:))
    
    // #3、配置 row（下一节 makeRow 方法里细讲）
    .makeRows(^(HoloTableViewRowMaker * _Nonnull make) {
        make.row(HoloExampleTableViewCell.class).model(@{@"bgColor": [UIColor cyanColor], @"text": @"cell", @"height": @44});
    });
}];

```





## 6、全量用法：创建 row

参见 [HoloTableViewRowMaker.h](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/HoloMaker/Row/HoloTableViewRowMaker.h) 及 [HoloTableRowMaker.h](https://github.com/HoloFoundation/HoloTableView/blob/master/HoloTableView/Classes/HoloMaker/Row/HoloTableRowMaker.h)



```objc
[self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
    // #1、给 row 配置 cell 类，返回 HoloTableRowMaker 对象
    make.row(HoloExampleTableViewCell.class)
    
    // #2、配置 cell
    // model 数据
    .model(NSObject.new)
    // 类型
    .style(UITableViewCellStyleDefault)
    // 复用标识
    .reuseId(@"reuseIdentifier")
    // tag 标识，用于 update 等操作
    .tag(TAG)
    // 高度
    .height(44)
    // 估算高度
    .estimatedHeight(40)
    // 是否高亮
    .shouldHighlight(NO)
    // 是否可编辑
    .canEdit(NO)
    // 是否可移动
    .canMove(NO)
    // 右滑控件
    .leadingSwipeActions(NSArray.new)
    // 左滑控件
    .trailingSwipeActions(NSArray.new)
    // 编辑标题
    .editingDeleteTitle(@"Delete")
    // 编辑样式
    .editingStyle(UITableViewCellEditingStyleNone)
    // 返回 model，实现该 block 的话，优先于 model 属性
    .modelHandler(^id _Nonnull{
        return NSObject.new;
    })
    // 返回类型，实现该 block 的话，优先于 style 属性
    .styleHandler(^UITableViewCellStyle(id  _Nullable model) {
        return UITableViewCellStyleDefault;
    })
    // 返回复用标识，实现该 block 的话，优先于 reuseId 属性
    .reuseIdHandler(^NSString * _Nonnull(id  _Nullable model) {
        return @"reuseIdentifier";
    })
    // 返回高度，实现该 block 的话，优先于 height 属性
    .heightHandler(^CGFloat(id  _Nullable model) {
        return 44;
    })
    // 返回估算高度，实现该 block 的话，优先于 estimatedHeight 属性
    .estimatedHeightHandler(^CGFloat(id  _Nullable model) {
        return 40;
    })
    // 返回是否高亮，实现该 block 的话，优先于 shouldHighlight 属性
    .shouldHighlightHandler(^BOOL(id  _Nullable model) {
        return NO;
    })
    // 返回是否可编辑，实现该 block 的话，优先于 canEdit 属性
    .canEditHandler(^BOOL(id  _Nullable model) {
        return NO;
    })
    // 返回是否可移动，实现该 block 的话，优先于 canMove 属性
    .canMoveHandler(^BOOL(id  _Nullable model) {
        return NO;
    })
    // 返回右滑控件，实现该 block 的话，优先于 leadingSwipeActions 属性
    .leadingSwipeActionsHandler(^NSArray * _Nonnull(id  _Nullable model) {
        return NSArray.new;
    })
    // 返回左滑控件，实现该 block 的话，优先于 trailingSwipeActions 属性
    .trailingSwipeActionsHandler(^NSArray * _Nonnull(id  _Nullable model) {
        return NSArray.new;
    })
    // 返回编辑标题，实现该 block 的话，优先于 editingDeleteTitle 属性
    .editingDeleteTitleHandler(^NSString * _Nonnull(id  _Nullable model) {
        return @"title";
    })
    // 返回编辑样式，实现该 block 的话，优先于 editingStyle 属性
    .editingStyleHandler(^UITableViewCellEditingStyle(id  _Nullable model) {
        return UITableViewCellEditingStyleNone;
    })
    // cell 即将被点击
    .willSelectHandler(^(id  _Nullable model) {
        
    })
    // cell 即将取消点击
    .willDeselectHandler(^(id  _Nullable model) {
        
    })
    // cell 取消点击
    .didDeselectHandler(^(id  _Nullable model) {
        
    })
    // cell 点击事件
    .didSelectHandler(^(id  _Nullable model) {
        
    })
    // cell 即将出现
    .willDisplayHandler(^(UITableViewCell * _Nonnull cell, id  _Nullable model) {
        
    })
    // cell 已经出现
    .didEndDisplayingHandler(^(UITableViewCell * _Nonnull cell, id  _Nullable model) {
        
    })
    // cell 高亮
    .didHighlightHandler(^(id  _Nullable model) {
        
    })
    // cell 取消高亮
    .didUnHighlightHandler(^(id  _Nullable model) {
        
    })
    // cell 附件按钮点击事件
    .accessoryButtonTappedHandler(^(id  _Nullable model) {
        
    })
    // cell 左滑事件
    .leadingSwipeHandler(^(id  _Nonnull action, NSInteger index, void (^ _Nonnull completionHandler)(BOOL)) {
        
    })
    // cell 右滑事件
    .trailingSwipeHandler(^(id  _Nonnull action, NSInteger index, void (^ _Nonnull completionHandler)(BOOL)) {
        
    })
    // cell 即将进入编辑状态
    .willBeginEditingHandler(^(id  _Nullable model) {
        
    })
    // cell 结束编辑状态
    .didEndEditingHandler(^(id  _Nullable model) {
        
    })
    // 返回 cell 目标移动位置
    .targetMoveHandler(^NSIndexPath * _Nonnull(NSIndexPath * _Nonnull atIndexPath, NSIndexPath * _Nonnull toIndexPath) {
        return NSIndexPath.new;
    })
    // cell 移动回调
    .moveHandler(^(NSIndexPath * _Nonnull atIndexPath, NSIndexPath * _Nonnull toIndexPath, void (^ _Nonnull completionHandler)(BOOL)) {
        
    })
    // 删除事件
    .editingDeleteHandler(^(id  _Nullable model, void (^ _Nonnull completionHandler)(BOOL)) {
        
    })
    // 添加事件
    .editingInsertHandler(^(id  _Nullable model) {
        
    })
    
    // 以下是 cell 默认调用方法，建议 cell 遵守 HoloTableViewCellProtocol，实现如下方法
    // 赋值 model 调用的方法
    .configSEL(@selector(holo_configureCellWithModel:))
    // 返回高度调用的方法，cell 实现该方法的话，优先于 heightHandler 属性及 height 属性
    .heightSEL(@selector(holo_heightForCellWithModel:))
    // 返回估算高度调用的方法，cell 实现该方法的话，优先于 estimatedHeightHandler 属性及 estimatedHeight 属性
    .estimatedHeightSEL(@selector(holo_estimatedHeightForCellWithModel:))
    // 返回是否高亮调用的方法，cell 实现该方法的话，优先于 shouldHighlightHandler 属性及 shouldHighlight 属性
    .shouldHighlightSEL(@selector(holo_shouldHighlightForCellWithModel:))
    // 即将被点击调用的方法，cell 实现该方法的话，优先于 willSelectHandler 属性
    .willSelectSEL(@selector(holo_willSelectCellWithModel:))
    // 即将取消点击调用的方法，cell 实现该方法的话，优先于 willDeselectHandler 属性
    .willDeselectSEL(@selector(holo_willDeselectCellWithModel:))
    // 取消点击调用的方法，cell 实现该方法的话，优先于 didDeselectHandler 属性
    .didDeselectSEL(@selector(holo_didDeselectCellWithModel:))
    // 点击调用的方法，cell 实现该方法的话，优先于 didSelectHandler 属性
    .didSelectSEL(@selector(holo_didSelectCellWithModel:))
    // 即将出现调用的方法，cell 实现该方法的话，优先于 willDisplayHandler 属性
    .willDisplaySEL(@selector(holo_willDisplayCellWithModel:))
    // 已经出现调用的方法，cell 实现该方法的话，优先于 didEndDisplayingHandler 属性
    .didEndDisplayingSEL(@selector(holo_didEndDisplayingCellWithModel:))
    // 高亮调用的方法，cell 实现该方法的话，优先于 didHighlightHandler 属性
    .didHighlightSEL(@selector(holo_didHighlightCellWithModel:))
    // 取消高亮调用的方法，cell 实现该方法的话，优先于 didHighlightHandler 属性
    .didUnHighlightSEL(@selector(didUnHighlightHandler:))
    // 附件按钮调用的方法，cell 实现该方法的话，优先于 accessoryButtonTappedHandler 属性
    .accessoryButtonTappedSEL(@selector(holo_accessoryButtonTappedCellWithModel:))
    // 即将进入编辑状态调用的方法，cell 实现该方法的话，优先于 willBeginEditingHandler 属性
    .willBeginEditingSEL(@selector(holo_willBeginEditingCellWithModel:))
    // 结束编辑状态调用的方法，cell 实现该方法的话，优先于 didEndEditingHandler 属性
    .didEndEditingSEL(@selector(holo_didEndEditingCellWithModel:));
}];
```