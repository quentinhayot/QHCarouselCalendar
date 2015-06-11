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
        
        _dayName = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, 15.0f)];
        [_dayName setTextAlignment:NSTextAlignmentCenter];
        [_dayName setTextColor:[UIColor whiteColor]];
        [self addSubview:_dayName];
        
        _dayNumber = [[UILabel alloc] initWithFrame: CGRectMake(0, _dayName.frame.size.height, self.frame.size.width, 15.0f)];
        [_dayNumber setTextAlignment:NSTextAlignmentCenter];
        [_dayNumber setTextColor:[UIColor whiteColor]];
        [_dayNumber setFont:[UIFont boldSystemFontOfSize:16.0]];
        [self addSubview:_dayNumber];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedDateChanged:) name:@"QHSelectedDateChanged" object:owner];
    }
    return self;
}

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
        self.backgroundColor = [UIColor darkGrayColor];
    }
    else{
        self.backgroundColor = [UIColor clearColor];
    }
    
}

-(void)selectedDateChanged:(NSNotification*)notification{
    NSDate *date = [notification.userInfo objectForKey:@"date"];
    if ([date isEqualToDate:self.date]){
        self.backgroundColor = [UIColor redColor];
    }
    else{
        [self setDate:_date];
    }
}

@end
