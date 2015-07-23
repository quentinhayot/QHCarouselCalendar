# QHCarouselCalendar
[![Build Status](https://travis-ci.org/quentinhayot/QHCarouselCalendar.svg?branch=master)](https://travis-ci.org/quentinhayot/QHCarouselCalendar)  
A cool calendar based on [Nick Lockwood](https://github.com/nicklockwood)'s [iCarousel](https://github.com/nicklockwood/iCarousel).

<img src="https://raw.github.com/quentinhayot/QHCarouselCalendar/master/Images/screenshot1.png" alt="QHCarouselCalendar" width="300px">

## Installation
### Cocoapods
Add this to your Podfile:  
```objective-c
pod 'QHCarouselCalendar'
```
Run a `pod install` and import the header where you need it:  
```objective-c
#import <QHCarouselCalendar.h>
```
### Manually
Drop QHCarouselCalendar.h and QHCarouselCalendar.m in your project, then  
```objective-c
#import "QHCarouselCalendar.h"
```

##Usage
#### Initialization
##### YourViewController.h
```objective-c
#import <UIKit/UIKit.h>
#import "QHCarouselCalendar.h"

@interface YourViewController : UIViewController <QHCarouselCalendarDataSource, QHCarouselCalendarDelegate>
@property (strong, nonatomic)QHCarouselCalendar *calendar;
@end
```
##### YourViewController.m
```objective-c
self.calendar = [[QHCarouselCalendar alloc] initWithFrame:someFrame]; // someFrame is the frame that you want to give to your calendar. Most likely self.view.frame
    self.calendar.dataSource = self;
    [self.view addSubview:self.calendar];
```

#### Data Source
##### QHCarouselCalendarDataSource
###### *REQUIRED:* View For Calendar
This method is called to get the view for each day. (Think about `cellForRowAtIndexPath` from `UITableViewController`)
```objective-c
  -(UIView*)viewForCalendar:(QHCarouselCalendar*)calendar forDate:(NSDate*)date withSuperviewFrame:(CGRect)frame reusingView:(UIView*)view;
```

###### *OPTIONAL:* Special dates
This method allows to flag a specific date as "special". It will have a different look on the day part of the calendar.
```objective-c
  -(BOOL)calendar:(QHCarouselCalendar*)calendar isDateSpecial:(NSDate*)date;
```

#### Delegate
##### QHCarouselCalendarDelegate
###### *OPTIONAL:* The selected date has changed
```objective-c
-(void)calendar:(QHCarouselCalendar*)calendar didChangeSelectedDate:(NSDate*)date;
```

###### *OPTIONAL:* Specify custom attributes for the calendar (possible attributes are listed below)
```objective-c
-(NSDictionary *)QHCarouselCalendarAttributesForCalendar:(QHCarouselCalendar*)calendar; 
```

#### Attributes
To change the calendar's behavior and/or look and feel, you need to implement the following delegate's method:
```objective-c
-(NSDictionary *)QHCarouselCalendarAttributesForCalendar:(QHCarouselCalendar*)calendar{
    return @{
             QHCarouselCalendarContentCarouselBackgroundColor : [UIColor clearColor],
             QHCarouselCalendarDayCarouselBackgroundColor : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2],
             QHCarouselCalendarMonthCarouselBackgroundColor : [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5],
             QHCarouselCalendarYearCarouselBackgroundColor : [UIColor colorWithRed:0 green:0 blue:0 alpha:1],
             QHCarouselCalendarYearCarouselHeight : [NSNumber numberWithFloat:0.0f]
             ... // and any other property that you want to customize (see below)
             };
} 
```

The customizable properties are:
##### Sizes
###### (float) QHCarouselCalendarYearCarouselHeight
The height of the Year part of the calendar. Set it to `0.0f` if you don't want to show years.
###### (float) QHCarouselCalendarMonthCarouselHeight
The height of the Month part of the calendar. Set it to `0.0f` if you don't want to show months.
###### (float) QHCarouselCalendarDayCarouselHeight
The height of the Day part of the calendar.

##### Colors
###### (UIColor*) QHCarouselCalendarYearCarouselBackgroundColor
The background color of the Year part of the calendar.
###### (UIColor*) QHCarouselCalendarMonthCarouselBackgroundColor
The background color of the Month part of the calendar.
###### (UIColor*) QHCarouselCalendarDayCarouselBackgroundColor
The background color of the Day part of the calendar.
###### (UIColor*) QHCarouselCalendarContentCarouselBackgroundColor
The background color of the Content part of the calendar.

###### (UIColor*) QHCarouselCalendarDayItemTodayBackgroundColor
The color used to hilight today's date on the Day part of the calendar
###### (UIColor*) QHCarouselCalendarDayItemSelectedBackgroundColor
The color used to hilight the selected date on the Day part of the calendar
###### (UIColor*) QHCarouselCalendarDayItemSpecialBackgroundColor
The color used to hilight dates marked as "special" on the Day part of the calendar. (see the Data Source)

###### (UIColor*) QHCarouselCalendarDayItemTodayBorderColor
The border color of today's date on the Day part of the calendar
###### (UIColor*) QHCarouselCalendarDayItemSelectedBorderColor
The border color of the selected date on the Day part of the calendar
###### (UIColor*) QHCarouselCalendarDayItemSpecialBorderColor
The border color of "special" dates on the Day part of the calendar. (see the Data Source)

###### (UIColor*) QHCarouselCalendarYearItemFontColor
The font color used for the Years
###### (UIColor*) QHCarouselCalendarMonthItemFontColor
The font color used for the Months
###### (UIColor*) QHCarouselCalendarDayItemNameFontColor
The font color used for the Days names
###### (UIColor*) QHCarouselCalendarDayItemNumberFontColor
The font color used for the Days numbers


##### Fonts
###### (UIFont*) QHCarouselCalendarYearItemFont
The font used for the Years
###### (UIFont*) QHCarouselCalendarMonthItemFont
The font used for the Months
###### (UIFont*) QHCarouselCalendarDayItemNameFont
The font used for the Days names
###### (UIFont*) QHCarouselCalendarDayItemNumberFont
The font used for the Days numbers

##### Carousel type
###### (iCarouselType) QHCarouselCalendarContentCarouselType
The type of the Carousel for the Content part of the calendar.  
Please refer to [iCarousel's documentation](https://github.com/nicklockwood/iCarousel#carousel-types) for the possible types.
KNOWN ISSUE: Some carousel types can behave strangely with this calendar.

## Credits
This class is heavily based on [Nick Lockwood](https://github.com/nicklockwood)'s great [iCarousel](https://github.com/nicklockwood/iCarousel).
