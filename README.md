# UIView-SmoothCorners
An easy way to enable [smooth corners](https://hackernoon.com/apples-icons-have-that-shape-for-a-very-good-reason-720d4e7c8a14) on UIView, without using the private `-[CALayer continuousCorners]` API ([rdar://42040072](https://openradar.appspot.com/42040072))

<image height=800 src="https://dsc.cloud/felix/Simulator-Screen-Shot-iPhone-X-2019-03-17-at-20.40.05.png">

## How to use

### Swift
#### As a UIView subclass: 
Add `SmoothView.swift` to your project
```
let myView = SmoothView()
myView.flx_smoothCorners = true
myView.layer.cornerRadius = 50
```
(Or change the base class of your main `UIView` subclass from `UIView` to `SmoothView`)

#### As a UIView category (that swizzles layoutSubviews):
Add `UIView+SmoothCorners.h` and `UIView+SmoothCorners.m` to your project
Add `#import "UIView+SmoothCorners.h"` to your bridging header
```
myView.layer.cornerRadius = 50
myView.flx_continuousCorners = true
```

### Objective-C
#### As a UIView subclass: 
Add `FLXSmoothView.h` and `FLXSmoothView.m` to your project
```
FLXSmoothView *myView = FLXSmoothView()
myView.flx_smoothCorners = YES;
myView.layer.cornerRadius = 50;
```
(Or change the base class of your main `UIView` subclass from `UIView` to `FLXSmoothView`)

#### As a UIView category (that swizzles layoutSubviews):
Add `UIView+SmoothCorners.h` and `UIView+SmoothCorners.m` to your project
```
myView.layer.cornerRadius = 50;
myView.flx_continuousCorners = YES;
```

## Shortcomings
- To make things simple for the category approach, I'm not observing the layer's corner radius changes. So make sure the corner radius is set before a layout pass or before setting `flx_continuousCorners` to `true`.
- No cocoapods or carthage support yet 