//
//  UIView+Rounded.h
//  UIView+Rounded
//
//  Created by Quentin Hayot on 05/05/2015.
//  Copyright (c) 2015 Quentin Hayot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Rounded)

/**-----------------------------------------------------------------------------
 * @name UIView+Rounded
 * -----------------------------------------------------------------------------
 */

/** Round the view's corners
 *
 * Round the view's corners and set an optional border.
 *
 * @param cornerRadius The radius of the corners
 * @param borderWidth The width of the border (set 0.0f for no border)
 * @param borderColor The color of the border
 */
-(void)roundWithCornerRadius:(float)cornerRadius andBorderWidth:(float)borderWidth andBorderColor:(UIColor*)color;

/** Make a circular view
 *
 * Make a view circular and set an optional border.
 * If your view is not square, it won't be a perfect circle.
 *
 * @param borderWidth The width of the border (set 0.0f for no border)
 * @param borderColor The color of the border
 */
-(void)circleWithBorderWidth:(float)borderWidth andBorderColor:(UIColor*)color;

@end
