# UIView+Rounded
[![Build Status](https://travis-ci.org/quentinhayot/UIView-Rounded.svg?branch=master)](https://travis-ci.org/quentinhayot/UIView-Rounded)  
An UIView category for rounded views !  
Create rounded or circular views that will keep their look upon resizing.

## Installation
### With Cocoapods
Add this to your Podfile:  
```objective-c
pod 'UIView-Rounded'
```
Run a `pod install` and import the header where you need it:  
```objective-c
#import <UIView+Rounded.h>
```
### Manually
Drop UIView+Rounded.h and .m in your project, then  
```objective-c
#import "UIView+Rounded.h"
```

## Usage
You can use this category in two ways:
### Create a rounded view with a custom border radius
```objective-c
UIView *myRoundedView = [[UIView alloc] init];  
[myRoundedView roundWithCornerRadius:0.5f andBorderWidth:2.0f andBorderColor:[UIColor whiteColor]];
```
### Create a perfect circle view
```objective-c
UIView *myRoundedView = [[UIView alloc] init]; 
[myRoundView circleWithBorderWidth:2.0f andBorderColor:[UIColor whiteColor]];  
// If the view doesn't have a 1:1 ratio, the result will not look good.

// You are responsible to create and remove the following observer
// if you want the circle view to stay a circle on resizing
[myRoundView addObserver:myRoundView forKeyPath:@"bounds" options:0 context:nil];
[myRoundView removeObserver:myRoundView forKeyPath:@"bounds"];


```
