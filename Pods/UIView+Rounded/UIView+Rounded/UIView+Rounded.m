//
//  UIView+Rounded.m
//  UIView+Rounded
//
//  Created by Quentin Hayot on 05/05/2015.
//  Copyright (c) 2015 Quentin Hayot. All rights reserved.
//

#import "UIView+Rounded.h"


NSString * const kRoundedPreviousFrameKey = @"kRoundedPreviousFrameKey";

@implementation UIView (Rounded)

-(void)roundWithCornerRadius:(float)cornerRadius andBorderWidth:(float)borderWidth andBorderColor:(UIColor*)color{
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setBorderColor:color.CGColor];
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *circularPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) cornerRadius:MAX(self.frame.size.width, self.frame.size.height)];
    circle.path = circularPath.CGPath;
    self.layer.mask = circle;
    CGRect frame = self.frame;
    [self previousFrame:&frame];
}

-(void)circleWithBorderWidth:(float)borderWidth andBorderColor:(UIColor*)color{
    if (self.frame.size.width != self.frame.size.height){
        NSLog(@"Warning: The original view is not square. It will not be a perfect circle.");
    }
    [self roundWithCornerRadius:self.frame.size.width/2 andBorderWidth:borderWidth andBorderColor:color];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"bounds"])
    {
        CGRect prevRect = [self previousFrame:nil];
        if (self.layer.cornerRadius == prevRect.size.width/2 && prevRect.size.width == prevRect.size.height){
            [self circleWithBorderWidth:self.layer.borderWidth andBorderColor:[UIColor colorWithCGColor:self.layer.borderColor]];
        }
    }
}

-(CGRect)previousFrame:(CGRect*)prev{
    static CGRect previousFrame;
    if (prev) {
        previousFrame = *prev;
    }
    return previousFrame;
}

@end
