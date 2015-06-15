//
//  QHCarouselCalendar.h
//  QHCarouselCalendar
//
//  Created by Quentin Hayot on 11/06/2015.
//  Copyright (c) 2015 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>

@protocol QHCarouselCalendarDataSource;
@protocol QHCarouselCalendarDelegate;

@interface QHCarouselCalendar : UIView <iCarouselDelegate, iCarouselDataSource>
{
    @private
    iCarousel *_yearCarousel;
    iCarousel *_monthCarousel;
    iCarousel *_dayCarousel;
    iCarousel *_contentCarousel;
    
}

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) NSDate *selectedDate;
@property (weak, nonatomic) id <QHCarouselCalendarDataSource> dataSource;
@property (weak, nonatomic) id <QHCarouselCalendarDelegate> delegate;
@end

@protocol QHCarouselCalendarDataSource <NSObject>
@required
-(UIView*)viewForCalendar:(QHCarouselCalendar*)calendar forDate:(NSDate*)date withSuperviewFrame:(CGRect)frame reusingView:(UIView*)view;

@optional
-(BOOL)calendar:(QHCarouselCalendar*)calendar isDateSpecial:(NSDate*)date;
@end

@protocol QHCarouselCalendarDelegate <NSObject>
// Keys for customize the calendar behavior
//   Heights
extern NSString *const QHCarouselCalendarYearCarouselHeight;
extern NSString *const QHCarouselCalendarMonthCarouselHeight;
extern NSString *const QHCarouselCalendarDayCarouselHeight;

//   Background colors
////   Carousels
extern NSString *const QHCarouselCalendarYearCarouselBackgroundColor;
extern NSString *const QHCarouselCalendarMonthCarouselBackgroundColor;
extern NSString *const QHCarouselCalendarDayCarouselBackgroundColor;
extern NSString *const QHCarouselCalendarContentCarouselBackgroundColor;
////   Day items
extern NSString *const QHCarouselCalendarDayItemTodayBackgroundColor;
extern NSString *const QHCarouselCalendarDayItemSelectedBackgroundColor;
extern NSString *const QHCarouselCalendarDayItemSpecialBackgroundColor;

//   Border colors
extern NSString *const QHCarouselCalendarDayItemTodayBorderColor;
extern NSString *const QHCarouselCalendarDayItemSelectedBorderColor;
extern NSString *const QHCarouselCalendarDayItemSpecialBorderColor;

//   Fonts
extern NSString *const QHCarouselCalendarYearItemFont;
extern NSString *const QHCarouselCalendarMonthItemFont;
extern NSString *const QHCarouselCalendarDayItemNameFont;
extern NSString *const QHCarouselCalendarDayItemNumberFont;

//   Font colors
extern NSString *const QHCarouselCalendarYearItemFontColor;
extern NSString *const QHCarouselCalendarMonthItemFontColor;
extern NSString *const QHCarouselCalendarDayItemNameFontColor;
extern NSString *const QHCarouselCalendarDayItemNumberFontColor;

//   Carousel types
extern NSString *const QHCarouselCalendarContentCarouselType;

@optional
-(void)calendar:(QHCarouselCalendar*)calendar didChangeSelectedDate:(NSDate*)date;
-(NSDictionary *)QHCarouselCalendarAttributesForCalendar:(QHCarouselCalendar*)calendar;       //Optional Function, Set the calendar behavior attributes by using above keys

@end