//
//  DNTextField.m
//  Pods
//
//  Created by Darren Ehlers on 11/8/13.
//
//

#import "DNTextField.h"

@implementation DNTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + self.horizontalPadding, bounds.origin.y + self.verticalPadding, bounds.size.width - self.horizontalPadding * 2, bounds.size.height - self.verticalPadding * 2);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (void)shake
{
    static int numberOfShakes = 4;

    CALayer*    layer   = [self layer];
    CGPoint     pos     = layer.position;

    CAKeyframeAnimation*    shakeAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef        shakePath       = CGPathCreateMutable();

    CGPathMoveToPoint(shakePath, NULL, pos.x, pos.y);

    for (int index = 0; index < numberOfShakes; ++index)
    {
        CGPathAddLineToPoint(shakePath, NULL, pos.x - 8, pos.y);
        CGPathAddLineToPoint(shakePath, NULL, pos.x + 8, pos.y);
    }

    CGPathAddLineToPoint(shakePath, NULL, pos.x, pos.y);
    CGPathCloseSubpath(shakePath);

    shakeAnimation.timingFunction   = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    shakeAnimation.duration         = 1.2;
    shakeAnimation.path             = shakePath;

    [layer addAnimation:shakeAnimation forKey:nil];
}

@end
