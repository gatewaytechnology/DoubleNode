//
//  DNTextField.h
//  Gateway Church and DoubleNode.com
//
//  Copyright (c) 2014 Gateway Church. All rights reserved.
//
//  Derived from work originally created by Darren Ehlers
//  Portions Copyright (c) 2012 DoubleNode.com and Darren Ehlers.
//  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JustType/JustType.h>

@interface DNTextField : JTTextField

@property (nonatomic, assign) float verticalPadding;
@property (nonatomic, assign) float horizontalPadding;

- (void)shake;

@end
