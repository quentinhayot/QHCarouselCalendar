//
//  QHCarouselCalendar.m
//  QHCarouselCalendar
//
//  Created by Quentin Hayot on 11/06/2015.
//  Copyright (c) 2015 example. All rights reserved.
//

#import "QHCarouselCalendar.h"
#import "QHCarouselCalendarDayView.h"

#define kQHDefaultYearViewHeight 45.0f
#define kQHDefaultMonthViewHeight 45.0f
#define kQHDefaultDayViewHeight 70.0f

// Keys for customize the calendar behavior
NSString *const QHCarouselCalendarYearCarouselHeight = @"QHCarouselCalendarYearCarouselHeight";
NSString *const QHCarouselCalendarMonthCarouselHeight = @"QHCarouselCalendarMonthCarouselHeight";
NSString *const QHCarouselCalendarDayCarouselHeight = @"QHCarouselCalendarDayCarouselHeight";

//   Background colors
////   Carousels
NSString *const QHCarouselCalendarYearCarouselBackgroundColor = @"QHCarouselCalendarYearCarouselBackgroundColor";
NSString *const QHCarouselCalendarMonthCarouselBackgroundColor = @"QHCarouselCalendarMonthCarouselBackgroundColor";
NSString *const QHCarouselCalendarDayCarouselBackgroundColor = @"QHCarouselCalendarDayCarouselBackgroundColor";
NSString *const QHCarouselCalendarContentCarouselBackgroundColor = @"QHCarouselCalendarContentCarouselBackgroundColor";
////   Day items
NSString *const QHCarouselCalendarDayItemTodayBackgroundColor = @"QHCarouselCalendarDayItemTodayBackgroundColor";
NSString *const QHCarouselCalendarDayItemSelectedBackgroundColor = @"QHCarouselCalendarDayItemSelectedBackgroundColor";
NSString *const QHCarouselCalendarDayItemSpecialBackgroundColor = @"QHCarouselCalendarDayItemSpecialBackgroundColor";

//   Border colors
NSString *const QHCarouselCalendarDayItemTodayBorderColor = @"QHCarouselCalendarDayItemTodayBorderColor";
NSString *const QHCarouselCalendarDayItemSelectedBorderColor = @"QHCarouselCalendarDayItemSelectedBorderColor";
NSString *const QHCarouselCalendarDayItemSpecialBorderColor = @"QHCarouselCalendarDayItemSpecialBorderColor";

//   Fonts
NSString *const QHCarouselCalendarYearItemFont = @"QHCarouselCalendarYearItemFont";
NSString *const QHCarouselCalendarMonthItemFont = @"QHCarouselCalendarMonthItemFont";
NSString *const QHCarouselCalendarDayItemNameFont = @"QHCarouselCalendarDayItemNameFont";
NSString *const QHCarouselCalendarDayItemNumberFont = @"QHCarouselCalendarDayItemNumberFont";

//   Font colors
NSString *const QHCarouselCalendarYearItemFontColor = @"QHCarouselCalendarYearItemFontColor";
NSString *const QHCarouselCalendarMonthItemFontColor = @"QHCarouselCalendarMonthItemFontColor";
NSString *const QHCarouselCalendarDayItemNameFontColor = @"QHCarouselCalendarDayItemNameFontColor";
NSString *const QHCarouselCalendarDayItemNumberFontColor = @"QHCarouselCalendarDayItemNumberFontColor";

//   Carousel types
NSString *const QHCarouselCalendarContentCarouselType = @"QHCarouselCalendarContentCarouselType";

@interface QHCarouselCalendar() <iCarouselDelegate, iCarouselDataSource>
// Keys for customize the calendar behavior
@property (nonatomic) float yearCarouselHeight;
@property (nonatomic) float monthCarouselHeight;
@property (nonatomic) float dayCarouselHeight;
//   Background colors
////   Carousels
@property (nonatomic, strong) UIColor *yearCarouselBackgroundColor;
@property (nonatomic, strong) UIColor *monthCarouselBackgroundColor;
@property (nonatomic, strong) UIColor *dayCarouselBackgroundColor;
@property (nonatomic, strong) UIColor *contentCarouselBackgroundColor;
////   Day items
@property (nonatomic, strong) UIColor *dayItemTodayBackgroundColor;
@property (nonatomic, strong) UIColor *dayItemSelectedBackgroundColor;
@property (nonatomic, strong) UIColor *dayItemSpecialBackgroundColor;

//   Border colors
@property (nonatomic, strong) UIColor *dayItemTodayBorderColor;
@property (nonatomic, strong) UIColor *dayItemSelectedBorderColor;
@property (nonatomic, strong) UIColor *dayItemSpecialBorderColor;

//   Fonts
@property (nonatomic, strong) UIFont *yearItemFont;
@property (nonatomic, strong) UIFont *monthItemFont;
@property (nonatomic, strong) UIFont *dayItemNameFont;
@property (nonatomic, strong) UIFont *dayItemNumberFont;

//   Font colors
@property (nonatomic, strong) UIColor *yearItemFontColor;
@property (nonatomic, strong) UIColor *monthItemFontColor;
@property (nonatomic, strong) UIColor *dayItemNameFontColor;
@property (nonatomic, strong) UIColor *dayItemNumberFontColor;

//   Carousel types
@property (nonatomic) iCarouselType contentCarouselType;
@end


@implementation QHCarouselCalendar

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return [self initWithFrame:self.frame];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
        [self applyCustomDefaults];
        _startDate = [self firstPossibleDate];
        _endDate = [self lastPossibleDate];
        
        _yearCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.yearCarouselHeight)];
        _yearCarousel.delegate = self;
        _yearCarousel.dataSource = self;
        [self addSubview:_yearCarousel];
        
        _monthCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, self.yearCarouselHeight, self.frame.size.width, self.monthCarouselHeight)];
        _monthCarousel.delegate = self;
        _monthCarousel.dataSource = self;
        [self addSubview:_monthCarousel];
        
        _dayCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, self.yearCarouselHeight+self.monthCarouselHeight, self.frame.size.width, self.dayCarouselHeight)];
        _dayCarousel.delegate = self;
        _dayCarousel.dataSource = self;
        [self addSubview:_dayCarousel];
        
        _contentCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, self.yearCarouselHeight+self.monthCarouselHeight+self.dayCarouselHeight, self.frame.size.width, self.frame.size.height-(self.yearCarouselHeight+self.monthCarouselHeight+self.dayCarouselHeight))];
        _contentCarousel.delegate = self;
        _contentCarousel.dataSource = self;
        _contentCarousel.clipsToBounds = YES;
        [self addSubview:_contentCarousel];
        
        self.selectedDate = [NSDate date];
        
        [self applyCustomDefaults];
    }
    return self;
}

#pragma mark - Setters

-(void)setDelegate:(id<QHCarouselCalendarDelegate>)delegate
{
    _delegate = delegate;
    [self applyCustomDefaults];
}

-(void)setDataSource:(id<QHCarouselCalendarDataSource>)dataSource{
    _dataSource = dataSource;
    [_contentCarousel reloadData];
}

-(void)setYearCarouselBackgroundColor:(UIColor *)yearCarouselBackgroundColor{
    _yearCarouselBackgroundColor = yearCarouselBackgroundColor;
    _yearCarousel.backgroundColor = _yearCarouselBackgroundColor;
}

-(void)setMonthCarouselBackgroundColor:(UIColor *)monthCarouselBackgroundColor{
    _monthCarouselBackgroundColor = monthCarouselBackgroundColor;
    _monthCarousel.backgroundColor = _monthCarouselBackgroundColor;
}

-(void)setDayCarouselBackgroundColor:(UIColor *)dayCarouselBackgroundColor{
    _dayCarouselBackgroundColor = dayCarouselBackgroundColor;
    _dayCarousel.backgroundColor = _dayCarouselBackgroundColor;
}

-(void)applyCustomDefaults
{
    NSDictionary *attributes;
    
    if ([self.delegate respondsToSelector:@selector(QHCarouselCalendarAttributesForCalendar:)]) {
        attributes = [self.delegate QHCarouselCalendarAttributesForCalendar:self];
    }
    
    self.yearCarouselHeight = attributes[QHCarouselCalendarYearCarouselHeight] ? [attributes[QHCarouselCalendarYearCarouselHeight] floatValue] : kQHDefaultYearViewHeight;
    self.monthCarouselHeight = attributes[QHCarouselCalendarMonthCarouselHeight] ? [attributes[QHCarouselCalendarMonthCarouselHeight] floatValue] : kQHDefaultMonthViewHeight;
    self.dayCarouselHeight = attributes[QHCarouselCalendarDayCarouselHeight] ? [attributes[QHCarouselCalendarDayCarouselHeight] floatValue] : kQHDefaultDayViewHeight;
    
    self.yearCarouselBackgroundColor = attributes[QHCarouselCalendarYearCarouselBackgroundColor] ? attributes[QHCarouselCalendarYearCarouselBackgroundColor] : [UIColor blackColor];
    self.monthCarouselBackgroundColor = attributes[QHCarouselCalendarMonthCarouselBackgroundColor] ? attributes[QHCarouselCalendarMonthCarouselBackgroundColor] : [UIColor darkGrayColor];
    self.dayCarouselBackgroundColor = attributes[QHCarouselCalendarDayCarouselBackgroundColor] ? attributes[QHCarouselCalendarDayCarouselBackgroundColor] : [UIColor lightGrayColor];
    self.contentCarouselBackgroundColor = attributes[QHCarouselCalendarContentCarouselBackgroundColor] ? attributes[QHCarouselCalendarContentCarouselBackgroundColor] : [UIColor clearColor];
    
    self.dayItemTodayBackgroundColor = attributes[QHCarouselCalendarDayItemTodayBackgroundColor] ? attributes[QHCarouselCalendarDayItemTodayBackgroundColor] : [UIColor darkGrayColor];
    self.dayItemSelectedBackgroundColor = attributes[QHCarouselCalendarDayItemSelectedBackgroundColor] ? attributes[QHCarouselCalendarDayItemSelectedBackgroundColor] : [UIColor redColor];
    self.dayItemSpecialBackgroundColor = attributes[QHCarouselCalendarDayItemSpecialBackgroundColor] ? attributes[QHCarouselCalendarDayItemSpecialBackgroundColor] : [UIColor clearColor];
    
    self.dayItemTodayBorderColor = attributes[QHCarouselCalendarDayItemTodayBorderColor] ? attributes[QHCarouselCalendarDayItemTodayBackgroundColor] : [UIColor clearColor];
    self.dayItemSelectedBorderColor = attributes[QHCarouselCalendarDayItemSelectedBorderColor] ? attributes[QHCarouselCalendarDayItemSelectedBackgroundColor] : [UIColor clearColor];
    self.dayItemSpecialBorderColor = attributes[QHCarouselCalendarDayItemSpecialBorderColor] ? attributes[QHCarouselCalendarDayItemSpecialBorderColor] : [UIColor whiteColor];
    
    self.yearItemFont = attributes[QHCarouselCalendarYearItemFont] ? attributes[QHCarouselCalendarYearItemFont] : [UIFont systemFontOfSize:20.0f];
    self.monthItemFont = attributes[QHCarouselCalendarMonthItemFont] ? attributes[QHCarouselCalendarMonthItemFont] : [UIFont systemFontOfSize:20.0f];
    self.dayItemNameFont = attributes[QHCarouselCalendarDayItemNameFont] ? attributes[QHCarouselCalendarDayItemNameFont] : [UIFont systemFontOfSize:10.0f];
    self.dayItemNumberFont = attributes[QHCarouselCalendarDayItemNumberFont] ? attributes[QHCarouselCalendarDayItemNumberFont] : [UIFont boldSystemFontOfSize:20.0];
    
    self.yearItemFontColor = attributes[QHCarouselCalendarYearItemFontColor] ? attributes[QHCarouselCalendarYearItemFontColor] : [UIColor whiteColor];
    self.monthItemFontColor = attributes[QHCarouselCalendarMonthItemFontColor] ? attributes[QHCarouselCalendarMonthItemFontColor] : [UIColor whiteColor];
    self.dayItemNameFontColor = attributes[QHCarouselCalendarDayItemNameFontColor] ? attributes[QHCarouselCalendarDayItemNameFontColor] : [UIColor whiteColor];
    self.dayItemNumberFontColor = attributes[QHCarouselCalendarDayItemNumberFontColor] ? attributes[QHCarouselCalendarDayItemNumberFontColor] : [UIColor whiteColor];
    
    self.contentCarouselType = attributes[QHCarouselCalendarContentCarouselType] ? (iCarouselType)[attributes[QHCarouselCalendarContentCarouselType] intValue]: iCarouselTypeCoverFlow;
    _contentCarousel.type = self.contentCarouselType;
    
    [self setNeedsDisplay];
}

-(void)setSelectedDate:(NSDate *)selectedDate{
    if ([selectedDate isEqualToDate:_selectedDate])
        return;
    _selectedDate = selectedDate;
    [_yearCarousel scrollToItemAtIndex:[self indexOfYearForDate:_selectedDate] duration:0.4];
    
    [_monthCarousel scrollToItemAtIndex:[self indexOfMonthForDate:_selectedDate] duration:0.5];
    
    
    [_dayCarousel scrollToItemAtIndex:[self indexOfDayForDate:_selectedDate] duration:0.6];
    
    [_contentCarousel scrollToItemAtIndex:[self indexOfDayForDate:_selectedDate] duration:0.7];
}

#pragma mark - iCarousel DataSource
-(NSInteger)numberOfItemsInCarousel:(iCarousel*)carousel{
    NSInteger items = 0;
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
    else if (carousel == _dayCarousel){
        return [self viewForDayAtIndex:index reusingView:view];
    }
    else if (carousel == _contentCarousel){
        return [self viewForContentAtIndex:index reusingView:view];
    }
    return nil;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionVisibleItems:
            if (carousel == _contentCarousel){
                return 5;
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QHSelectedDateChanged" object:self userInfo:@{@"date":_selectedDate}];
    if ([self.delegate respondsToSelector:@selector(calendar:didChangeSelectedDate:)])
        [self.delegate calendar:self didChangeSelectedDate:_selectedDate];
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0f, self.yearCarouselHeight)];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:index];
    NSDate *targetDate = [calendar dateByAddingComponents:dateComponents toDate:self.startDate  options:0];
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy"];
    
    label.font = self.yearItemFont;
    label.textColor = self.yearItemFontColor;
    label.text = [df stringFromDate:targetDate];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.center;
    return label;
}

#pragma mark - Month carousel DataSource
-(NSInteger)numberOfItemsInMonthCarousel{
    return [self indexOfMonthForDate:_endDate];
}

-(UIView*)viewForMonthAtIndex:(NSInteger)index reusingView:(UIView*)view{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0f, self.monthCarouselHeight)];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:index];
    NSDate *targetDate = [calendar dateByAddingComponents:dateComponents toDate:self.startDate  options:0];
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM"];
    
    label.font = self.monthItemFont;
    label.textColor = self.monthItemFontColor;
    label.text = [df stringFromDate:targetDate];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.center;
    return label;
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
    
    v.todayBackgroundColor = self.dayItemTodayBackgroundColor;
    v.todayBorderColor = self.dayItemTodayBorderColor;
    v.selectedBackgroundColor = self.dayItemSelectedBackgroundColor;
    v.selectedBorderColor = self.dayItemSelectedBorderColor;
    v.specialBackgroundColor = self.dayItemSpecialBackgroundColor;
    v.specialBorderColor = self.dayItemSpecialBorderColor;
    v.nameFont = self.dayItemNameFont;
    v.nameFontColor = self.dayItemNameFontColor;
    v.numberFont = self.dayItemNumberFont;
    v.numberFontColor = self.dayItemNumberFontColor;
    
    if ([self.delegate respondsToSelector:@selector(calendar:isDateSpecial:)]){
        v.isSpecial = [self.dataSource calendar:self isDateSpecial:[self dateForIndexOfDay:index]];
    }
    return v;
}

#pragma mark - Content carousel DataSource
-(NSInteger)numberOfItemsInContentCarousel{
    return [self indexOfDayForDate:_endDate];
}

-(UIView*)viewForContentAtIndex:(NSInteger)index reusingView:(UIView*)view{
    return [self.dataSource viewForCalendar:self forDate:[self dateForIndexOfDay:index] withSuperviewFrame:_contentCarousel.contentView.frame reusingView:view];
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
