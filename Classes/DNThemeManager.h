//
//  DNThemeManager.h
//  DoubleNode.com
//
//  Created by Darren Ehlers on 10/27/12.
//  Copyright (c) 2012 DoubleNode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DNUtilities.h"

#import "ADVTheme.h"

@class DNTextView, DNTextField, DNLabel, DNSegmentedControl;

@protocol DNThemeProtocol <ADVTheme, NSObject>

@end

@interface DNThemeManager : ADVThemeManager

+ (NSString*)themeName;
+ (id <DNThemeProtocol>)sharedTheme;

+ (NSString*)customizeNibNameWithClass:(NSString*)className
                             withGroup:(NSString*)group
                             andScreen:(NSString*)screen;

+ (void)customizeView:(UIView*)view
            withGroup:(NSString*)group
            andScreen:(NSString*)screen
              andItem:(NSString*)item;

+ (void)customizeView:(UIView*)view
            withGroup:(NSString*)group
            andScreen:(NSString*)screen
         andViewState:(NSString*)viewState
              andItem:(NSString*)item;

+ (void)customizeLabel:(DNLabel*)lblView
             withGroup:(NSString*)group
             andScreen:(NSString*)screen
               andItem:(NSString*)item;

+ (void)customizeLabel:(DNLabel*)lblView
             withGroup:(NSString*)group
             andScreen:(NSString*)screen
          andViewState:(NSString*)viewState
               andItem:(NSString*)item;

+ (void)customizeImage:(UIImageView*)imgView
             withGroup:(NSString*)group
             andScreen:(NSString*)screen
               andItem:(NSString*)item;

+ (void)customizeImage:(UIImageView*)imgView
             withGroup:(NSString*)group
             andScreen:(NSString*)screen
          andViewState:(NSString*)viewState
               andItem:(NSString*)item;

+ (void)customizeButton:(UIButton*)btnView
              withGroup:(NSString*)group
              andScreen:(NSString*)screen
                andItem:(NSString*)item;

+ (void)customizeButton:(UIButton*)btnView
              withGroup:(NSString*)group
              andScreen:(NSString*)screen
           andViewState:(NSString*)viewState
                andItem:(NSString*)item;

+ (void)customizeTextField:(DNTextField*)txtfldView
                 withGroup:(NSString*)group
                 andScreen:(NSString*)screen
                   andItem:(NSString*)item;

+ (void)customizeTextField:(DNTextField*)txtfldView
                 withGroup:(NSString*)group
                 andScreen:(NSString*)screen
              andViewState:(NSString*)viewState
                   andItem:(NSString*)item;

+ (void)customizeTextView:(DNTextView*)txtView
                withGroup:(NSString*)group
                andScreen:(NSString*)screen
                  andItem:(NSString*)item;

+ (void)customizeTextView:(DNTextView*)txtView
                withGroup:(NSString*)group
                andScreen:(NSString*)screen
             andViewState:(NSString*)viewState
                  andItem:(NSString*)item;

+ (void)customizeSegmentedControl:(DNSegmentedControl*)segmentedControl
                        withGroup:(NSString*)group
                        andScreen:(NSString*)screen
                          andItem:(NSString*)item;

+ (void)customizeSegmentedControl:(DNSegmentedControl*)segmentedControl
                        withGroup:(NSString*)group
                        andScreen:(NSString*)screen
                     andViewState:(NSString*)viewState
                          andItem:(NSString*)item;

+ (void)customizeBarButtonItem:(UIBarButtonItem*)barButtonItem
                     withGroup:(NSString*)group
                     andScreen:(NSString*)screen
                       andItem:(NSString*)item;

+ (void)customizeBarButtonItem:(UIBarButtonItem*)barButtonItem
                     withGroup:(NSString*)group
                     andScreen:(NSString*)screen
                  andViewState:(NSString*)viewState
                       andItem:(NSString*)item;

@end
