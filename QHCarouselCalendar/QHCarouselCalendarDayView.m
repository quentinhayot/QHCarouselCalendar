//
//  QHCarouselCalendarDayView.m
//  QHCarouselCalendar
//
//  Created by Quentin Hayot on 11/06/2015.
//  Copyright (c) 2015 example. All rights reserved.
//

#import "QHCarouselCalendarDayView.h"
#import <UIView+Rounded.h>

@implementation QHCarouselCalendarDayView

-(instancetype)initWithOwner:(id)owner{
    self = [super init];
    if (self){
        self.frame = CGRectMake(0, 0, 50.0f, 50.0f);
        [self circleWithBorderWidth:0 andBorderColor:[UIColor clearColor]];
        
        _dayName = [[UILabel alloc] initWithFrame: CGRectMake(0, self.frame.size.height/5, self.frame.size.width, 9.0f)];
        [_dayName setTextAlignment:NSTextAlignmentCenter];
        self.nameFontColor = [UIColor whiteColor];
        self.nameFont = [UIFont systemFontOfSize:10.0];
        [self addSubview:_dayName];
        
        _dayNumber = [[UILabel alloc] initWithFrame: CGRectMake(0, _dayName.frame.origin.y+_dayName.frame.size.height+2.0, self.frame.size.width, 18.0f)];
        [_dayNumber setTextAlignment:NSTextAlignmentCenter];
        self.numberFontColor = [UIColor whiteColor];
        self.numberFont = [UIFont boldSystemFontOfSize:20.0];
        [self addSubview:_dayNumber];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedDateChanged:) name:@"QHSelectedDateChanged" object:owner];
        
        self.selectedBackgroundColor = [UIColor redColor];
        self.selectedBorderColor = [UIColor clearColor];
        self.todayBackgroundColor = [UIColor darkGrayColor];
        self.todayBorderColor = [UIColor clearColor];
        self.specialBackgroundColor = [UIColor clearColor];
        self.specialBorderColor = [UIColor whiteColor];
        [self updateView];
    }
    return self;
}

#pragma mark - Update methods
-(void)updateView{
    [UIView beginAnimations:@"updateView" context:nil];
    if (_isSelected) {
        self.backgroundColor = self.selectedBackgroundColor;
    }
    else if (_isToday){
        self.backgroundColor = self.todayBackgroundColor;
    }
    else if (self.isSpecial){
        self.backgroundColor = self.specialBackgroundColor;
    }
    else{
        self.backgroundColor = [UIColor clearColor];
    }
    
    if (self.isSpecial){
        self.layer.borderColor = self.specialBorderColor.CGColor;
    }
    else if(_isSelected){
        self.layer.borderColor = self.selectedBorderColor.CGColor;
    }
    else if(_isToday){
        self.layer.borderColor = self.todayBorderColor.CGColor;
    }
    else{
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    _dayName.font = self.nameFont;
    _dayNumber.font = self.numberFont;
    _dayName.textColor = self.nameFontColor;
    _dayNumber.textColor = self.numberFontColor;
    
    [UIView commitAnimations];
}

#pragma mark - Setters
-(void)setDate:(NSDate *)date{
    _date = date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEEEE";
    [_dayName setText: [df stringFromDate:_date]];
    df.dateFormat = @"d";
    [_dayNumber setText: [df stringFromDate:_date]];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    if([today isEqualToDate:_date]) {
        _isToday = YES;
    }
    else{
        _isToday = NO;
    }
    [self updateView];
}

-(void)setIsSpecial:(BOOL)isSpecial{
    _isSpecial = isSpecial;
    [self updateView];
}
-(void)setTodayBackgroundColor:(UIColor *)todayBackgroundColor{
    _todayBackgroundColor = todayBackgroundColor;
    [self updateView];
}
-(void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor{
    _selectedBackgroundColor = selectedBackgroundColor;
    [self updateView];
}
-(void)setSpecialBackgroundColor:(UIColor *)specialBackgroundColor{
    _specialBackgroundColor = specialBackgroundColor;
    [self updateView];
}
-(void)setTodayBorderColor:(UIColor *)todayBorderColor{
    _todayBorderColor = todayBorderColor;
    [self updateView];
}
-(void)setSelectedBorderColor:(UIColor *)selectedBorderColor{
    _selectedBorderColor = selectedBorderColor;
    [self updateView];
}
-(void)setSpecialBorderColor:(UIColor *)specialBorderColor{
    _specialBorderColor = specialBorderColor;
    [self updateView];
}
-(void)setNameFont:(UIFont *)nameFont{
    _nameFont = nameFont;
    [self updateView];
}
-(void)setNumberFont:(UIFont *)numberFont{
    _numberFont = numberFont;
    [self updateView];
}
-(void)setNameFontColor:(UIColor *)nameFontColor{
    _nameFontColor = nameFontColor;
    [self updateView];
}
-(void)setNumberFontColor:(UIColor *)numberFontColor{
    _numberFontColor = numberFontColor;
    [self updateView];
}

#pragma mark - Observers
-(void)selectedDateChanged:(NSNotification*)notification{
    NSDate *date = [notification.userInfo objectForKey:@"date"];
    if ([date isEqualToDate:self.date]){
        _isSelected = YES;
    }
    else{
        _isSelected = NO;
    }
    [self updateView];
}


@end
