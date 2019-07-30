# HoloTableView

[![CI Status](https://img.shields.io/travis/gonghonglou/HoloTableView.svg?style=flat)](https://travis-ci.org/gonghonglou/HoloTableView)
[![Version](https://img.shields.io/cocoapods/v/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)
[![License](https://img.shields.io/cocoapods/l/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)
[![Platform](https://img.shields.io/cocoapods/p/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

If you want to set the model for your UITableViewCell or change the height of your UITableViewCell, your UITableViewCell must conform to protocol: `HoloTableViewProtocol` and implement their selectors: 

```objective-c
- (void)cellForRow:(id)model;

+ (CGFloat)heightForRow:(id)model;
```

## Usage

```objective-c
[self.view addSubview:self.tableView];

[self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
   // one cell
   make.row(@"HoloExampleOneTableViewCell")
   .model(@{@"title":@"one cell"})
   .height(22);
   
   // two cell
   make.row(@"HoloExampleTwoTableViewCell")
   .model(@{@"title":@"two cell"})
   .height(44);
   
   // three cell
   make.row(@"HoloTableViewTgreeCell")
   .model([NSObject new])
   .height(66)
   .tag(@"three")
   .willDisplayHandler(^(UITableViewCell * _Nonnull cell) {
       NSLog(@"will display");
   })
   .didEndDisplayingHandler(^(UITableViewCell * _Nonnull cell) {
       NSLog(@"did end displaying");
   })
   .didSelectHandler(^(id  _Nonnull model) {
       NSLog(@"did select model : %@", model);
   });
}];
// etc...
    
[self.tableView reloadData];

```

## Installation

HoloTableView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HoloTableView'
```

## Author

gonghonglou, gonghonglou@icloud.com

## License

HoloTableView is available under the MIT license. See the LICENSE file for more info.


