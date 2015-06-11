//
//  QHCarouselCalendar.h
//  QHCarouselCalendar
//
//  Created by Quentin Hayot on 11/06/2015.
//  Copyright (c) 2015 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>

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
@end
