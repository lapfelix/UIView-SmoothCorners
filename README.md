# UIView-SmoothCorners
An easy way to enable [smooth corners](https://hackernoon.com/apples-icons-have-that-shape-for-a-very-good-reason-720d4e7c8a14) on UIView, without using the private `-[CALayer continuousCorners]` API ([rdar://42040072](https://openradar.appspot.com/42040072))

<image height=800 src="https://dsc.cloud/felix/Simulator-Screen-Shot-iPhone-X-2019-03-17-at-20.40.05.png">

## How to use
### Objective-C
```
myView.layer.cornerRadius = 50;
myView.flx_continuousCorners = YES;
```

### Swift
```
myView.layer.cornerRadius = 50
myView.flx_continuousCorners = true
```

## Shortcomings
- To make things simple, it's a UIView category and I'm not observing the layer's corner radius changes, so make sure you set the corner radius before a layout pass or setting `flx_continuousCorners` to `true`.
- No cocoapods or carthage support yet 
