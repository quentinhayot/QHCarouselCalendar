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
}


@property (strong, nonatomic) NSDate *date;

-(instancetype) init __attribute__((unavailable("Use 'initWithOwner:' instead")));
-(instancetype)initWithOwner:(id)owner;

@end
