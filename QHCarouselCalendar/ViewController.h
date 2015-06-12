//
//  ViewController.h
//  QHCarouselCalendar
//
//  Created by Quentin Hayot on 11/06/2015.
//  Copyright (c) 2015 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHCarouselCalendar.h"

@interface ViewController : UIViewController <QHCarouselCalendarDataSource, QHCarouselCalendarDelegate>

@property (strong, nonatomic)QHCarouselCalendar *calendar;

@end

