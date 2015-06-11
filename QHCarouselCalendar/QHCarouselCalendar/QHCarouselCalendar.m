//
//  QHCarouselCalendar.m
//  QHCarouselCalendar
//
//  Created by Quentin Hayot on 11/06/2015.
//  Copyright (c) 2015 example. All rights reserved.
//

#import "QHCarouselCalendar.h"
#import "QHCarouselCalendarDayView.h"

#define QHDefaultYearViewHeight 50.0f
#define QHDefaultMonthViewHeight 50.0f
#define QHDefaultDayViewHeight 70.0f

@interface QHCarouselCalendar ()

@end

@implementation QHCarouselCalendar

-(instancetype)init{
    self = [super init];
    if (self){
        _startDate = [self firstPossibleDate];
        _endDate = [self lastPossibleDate];
        
        _yearCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, QHDefaultYearViewHeight)];
        _yearCarousel.delegate = self;
        _yearCarousel.dataSource = self;
        [self addSubview:_yearCarousel];
        
        _monthCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, QHDefaultYearViewHeight, self.frame.size.width, QHDefaultMonthViewHeight)];
        _monthCarousel.delegate = self;
        _monthCarousel.dataSource = self;
        [self addSubview:_monthCarousel];
        
        _dayCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, QHDefaultYearViewHeight+QHDefaultMonthViewHeight, self.frame.size.width, QHDefaultDayViewHeight)];
        _dayCarousel.delegate = self;
        _dayCarousel.dataSource = self;
        _dayCarousel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self addSubview:_dayCarousel];
        
        _contentCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, QHDefaultYearViewHeight+QHDefaultMonthViewHeight+QHDefaultDayViewHeight, self.frame.size.width, self.frame.size.height-(QHDefaultYearViewHeight+QHDefaultMonthViewHeight+QHDefaultDayViewHeight))];
        _contentCarousel.delegate = self;
        _contentCarousel.dataSource = self;
        _contentCarousel.type = iCarouselTypeCoverFlow2;
        _contentCarousel.backgroundColor = [UIColor colorWithRed:1.0f green:0 blue:0 alpha:0.4];
        [self addSubview:_contentCarousel];
        
        self.selectedDate = [NSDate date];
    }
    return self;
}

-(void)setSelectedDate:(NSDate *)selectedDate{
    if ([selectedDate isEqualToDate:_selectedDate])
        return;
    _selectedDate = selectedDate;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QHSelectedDateChanged" object:self userInfo:@{@"date":_selectedDate}];
    [_yearCarousel scrollToItemAtIndex:[self indexOfYearForDate:_selectedDate] duration:0.4];
    
    [_monthCarousel scrollToItemAtIndex:[self indexOfMonthForDate:_selectedDate] duration:0.5];
    
    
    [_dayCarousel scrollToItemAtIndex:[self indexOfDayForDate:_selectedDate] duration:0.6];
    
    [_contentCarousel scrollToItemAtIndex:[self indexOfDayForDate:_selectedDate] duration:0.7];
}

#pragma mark - iCarousel DataSource
-(NSInteger)numberOfItemsInCarousel:(iCarousel*)carousel{
    NSInteger items;
    if (carousel == _yearCarousel){
        items = [self numberOfItemsInYearCarousel];
    }
    else if (carousel == _monthCarousel){
        items = [self numberOfItemsInMonthCarousel];
    }
    else if (carousel == _dayCarousel || carousel == _contentCarousel){
        items = [self numberOfItemsInDayCarousel];
    }
    return items;
}

-(UIView*)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (carousel == _yearCarousel) {
        return [self viewForYearAtIndex:index reusingView:view];
    }
    else if (carousel == _monthCarousel){
        return [self viewForMonthAtIndex:index reusingView:view];
    }
    else if (carousel == _dayCarousel || carousel == _contentCarousel){
        return [self viewForDayAtIndex:index reusingView:view];
    }
    return nil;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionVisibleItems:
            if (carousel == _contentCarousel){
                return 3;
            }
            else if (carousel == _dayCarousel){
                return 7;
            }
        default:
        {
            return value;
        }
    }
}

#pragma mark - Update date
-(void)carouselHasChanged:(iCarousel*)carousel{
    if ([_yearCarousel isScrolling] || [_yearCarousel isDecelerating] || [_monthCarousel isScrolling] || [_monthCarousel isDecelerating] || [_dayCarousel isScrolling] || [_dayCarousel isDecelerating] || [_contentCarousel isScrolling] || [_contentCarousel isDecelerating])
        return;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents =
    [calendar components:(NSCalendarUnitYear |
                          NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.startDate];
    if (carousel == _yearCarousel){
        [dateComponents setYear:carousel.currentItemIndex];
        self.selectedDate = [calendar dateByAddingComponents:dateComponents toDate:self.startDate options:0];
    }
    else if (carousel == _monthCarousel){
        [dateComponents setYear:0];
        [dateComponents setMonth:carousel.currentItemIndex];
        self.selectedDate = [calendar dateByAddingComponents:dateComponents toDate:self.startDate options:0];
    }
    else if (carousel == _dayCarousel || carousel == _contentCarousel){
        self.selectedDate = [self dateForIndexOfDay:carousel.currentItemIndex];
    }
}

#pragma mark - iCarousel Protocol
-(void)carouselDidEndDecelerating:(iCarousel *)carousel{
    [self carouselHasChanged:carousel];
}

-(void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    [self carouselHasChanged:carousel];
}

-(void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    [self carouselHasChanged:carousel];
}



#pragma mark - Year carousel DataSource
-(NSInteger)numberOfItemsInYearCarousel{
    return [self indexOfYearForDate:_endDate];
}

-(UIView*)viewForYearAtIndex:(NSInteger)index reusingView:(UIView*)view{
    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0f, QHDefaultYearViewHeight)];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:index];
    NSDate *targetDate = [calendar dateByAddingComponents:dateComponents toDate:self.startDate  options:0];
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy"];
    
    test.text = [df stringFromDate:targetDate];
    test.textAlignment = NSTextAlignmentCenter;
    return test;
}

#pragma mark - Month carousel DataSource
-(NSInteger)numberOfItemsInMonthCarousel{
    return [self indexOfMonthForDate:_endDate];
}

-(UIView*)viewForMonthAtIndex:(NSInteger)index reusingView:(UIView*)view{
    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0f, QHDefaultYearViewHeight)];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:index];
    NSDate *targetDate = [calendar dateByAddingComponents:dateComponents toDate:self.startDate  options:0];
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM"];
    
    test.text = [df stringFromDate:targetDate];
    test.textAlignment = NSTextAlignmentCenter;
    return test;
}

#pragma mark - Day carousel DataSource
-(NSInteger)numberOfItemsInDayCarousel{
    return [self indexOfDayForDate:_endDate];
}

-(UIView*)viewForDayAtIndex:(NSInteger)index reusingView:(UIView*)view{
    QHCarouselCalendarDayView *v;
    if (view)
        v = (QHCarouselCalendarDayView*)view;
    else
        v = [[QHCarouselCalendarDayView alloc] initWithOwner:self];
    v.date = [self dateForIndexOfDay:index];
    v.center = self.center;
    
    
    
    return v;
}


#pragma mark - Helpers
-(NSDate*)firstPossibleDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy"];
    return [df dateFromString:@"0001"];
}

-(NSDate*)lastPossibleDate{
    return [NSDate distantFuture];
}

-(NSInteger)indexOfYearForDate:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear
                                                        fromDate:self.startDate
                                                          toDate:date
                                                         options:0];
    return [components year];
}

-(NSInteger)indexOfMonthForDate:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth
                                                        fromDate:self.startDate
                                                          toDate:date
                                                         options:0];
    return [components month];
}

-(NSInteger)indexOfDayForDate:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                        fromDate:self.startDate
                                                          toDate:date
                                                         options:0];
    return [components day];
}

-(NSDate*)dateForIndexOfDay:(NSInteger)index{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:index];
    return [calendar dateByAddingComponents:dateComponents toDate:self.startDate  options:0];
}
@end
