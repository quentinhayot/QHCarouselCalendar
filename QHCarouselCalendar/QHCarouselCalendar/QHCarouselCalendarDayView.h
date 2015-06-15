//
//  QHCarouselCalendarDayView.h
//  QHCarouselCalendar
//
//  Created by Quentin Hayot on 11/06/2015.
//  Copyright (c) 2015 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHCarouselCalendarDayView : UIView
{
    @private
    UILabel *_dayName;
    UILabel *_dayNumber;
    BOOL _isToday;
    BOOL _isSelected;
}


@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isSpecial;
@property (nonatomic, strong) UIColor *todayBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *specialBackgroundColor;
@property (nonatomic, strong) UIColor *todayBorderColor;
@property (nonatomic, strong) UIColor *selectedBorderColor;
@property (nonatomic, strong) UIColor *specialBorderColor;
@property (nonatomic, strong) UIFont *nameFont;
@property (nonatomic, strong) UIFont *numberFont;
@property (nonatomic, strong) UIColor *nameFontColor;
@property (nonatomic, strong) UIColor *numberFontColor;

-(instancetype) init __attribute__((unavailable("Use 'initWithOwner:' instead")));
-(instancetype)initWithOwner:(id)owner;

@end
