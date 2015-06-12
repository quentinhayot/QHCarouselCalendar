//
//  ViewController.m
//  QHCarouselCalendar
//
//  Created by Quentin Hayot on 11/06/2015.
//  Copyright (c) 2015 example. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.calendar = [[QHCarouselCalendar alloc] initWithFrame:self.view.frame];
    self.calendar.dataSource = self;
    [self.view addSubview:self.calendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView*)viewForCalendar:(QHCarouselCalendar *)calendar forDate:(NSDate *)date withSuperviewFrame:(CGRect)frame reusingView:(UIView *)view{
    UIView *v;
    if (view)
        v = view;
    else{
        CGRect viewFrame = CGRectMake(0, 0, frame.size.width/1.5, frame.size.height);
        v = [[UIView alloc] initWithFrame:viewFrame];
    }
    uint32_t red = arc4random_uniform(5);
    uint32_t green = arc4random_uniform(5);
    uint32_t blue = arc4random_uniform(5);
    v.backgroundColor = [UIColor colorWithRed:1.0/red green:1.0/green blue:1.0/blue alpha:1];
    return v;
}

@end
