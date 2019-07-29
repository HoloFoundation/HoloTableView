# HoloTableView

[![CI Status](https://img.shields.io/travis/gonghonglou/HoloTableView.svg?style=flat)](https://travis-ci.org/gonghonglou/HoloTableView)
[![Version](https://img.shields.io/cocoapods/v/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)
[![License](https://img.shields.io/cocoapods/l/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)
[![Platform](https://img.shields.io/cocoapods/p/HoloTableView.svg?style=flat)](https://cocoapods.org/pods/HoloTableView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Yore UITableViewCell must conforms to protocol: `HoloTableViewProtocol` and implement their selectors: 

```objective-c
- (void)cellForRow:(id)model;

+ (CGFloat)heightForRow:(id)model;
```

## Usage

```objective-c
[self.tableView holo_makeRows:^(HoloTableViewRowMaker * _Nonnull make) {
   make.row(@"HoloTableViewOneCell")
   .model(@{@"title":@"one cell"});
   
   make.row(@"HoloTableViewTwoCell")
   .model([NSObject new])
   .tag(@"two")
   .willDisplayHandler(^(UITableViewCell * _Nonnull cell) {
       NSLog(@"willDisplayHandler");
   })
   .didEndDisplayingHandler(^(UITableViewCell * _Nonnull cell) {
       NSLog(@"didEndDisplayingHandler");
   })
   .didSelectHandler(^(id  _Nonnull model) {
       NSLog(@"did select model : %@", model);
   });
}];
    
[self.tableView reloadData];

// etc...
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


