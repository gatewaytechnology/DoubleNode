//
//  DNStateViewController.m
//  Phoenix
//
//  Created by Darren Ehlers on 11/9/13.
//  Copyright (c) 2013 Table Project. All rights reserved.
//

#import "DNStateViewController.h"

#import "DNUtilities.h"

@interface DNStateViewController ()

@end

@implementation DNStateViewController

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [self updateToViewState:currentViewState animated:YES completion:nil];
}

- (void)viewStateWillAppear:(NSString*)newViewState
                   animated:(BOOL)animated
{
}

- (void)viewStateDidAppear:(NSString*)newViewState
                  animated:(BOOL)animated
{
}

- (void)changeToViewState:(NSString*)newViewState
                 animated:(BOOL)animated
               completion:(void(^)(BOOL finished))completion
{
    if ([newViewState isEqualToString:currentViewState] == YES)
    {
        return;
    }

    [self updateToViewState:newViewState animated:animated completion:completion];
}

- (void)updateToViewState:(NSString*)newViewState
                 animated:(BOOL)animated
               completion:(void(^)(BOOL finished))completion
{
    [DNUtilities runOnMainThreadWithoutDeadlocking:^
     {
         [self viewStateWillAppear:newViewState animated:animated];

         NSString*  currentState = currentViewState;
         if ([currentState isEqualToString:newViewState] == YES)
         {
             currentState = previousViewState;
         }

         [self changeFromCurrentState:currentState
                           toNewState:newViewState
                             animated:animated
                           completion:^(BOOL finished)
          {
              previousViewState = currentState;
              currentViewState  = newViewState;

              [DNUtilities runOnMainThreadWithoutDeadlocking:^
               {
                   [self viewStateDidAppear:newViewState animated:animated];
                   if (completion != nil) {   completion(finished);   }
               }];
          }];
     }];
}

- (void)changeFromCurrentState:(NSString*)currentState
                    toNewState:(NSString*)newState
                      animated:(BOOL)animated
                    completion:(void(^)(BOOL finished))completion
{
    DNStateOptions* options = [DNStateOptions stateOptions];
    options.animated    = animated;
    options.completion  = completion;

    if (currentState != nil)
    {
        NSString*   functionName    = [NSString stringWithFormat:@"changeFromViewState%@To%@:", currentState, newState];
        if ([self respondsToSelector:NSSelectorFromString(functionName)] == YES)
        {
            [self performViewStateSelector:NSSelectorFromString(functionName) options:options];
            return;
        }
    }

    BOOL    anyRun = NO;

    NSString*   functionName    = [NSString stringWithFormat:@"changeFromViewState%@:", currentState];
    if ([self respondsToSelector:NSSelectorFromString(functionName)] == YES)
    {
        [self performViewStateSelector:NSSelectorFromString(functionName) options:options];
        anyRun = YES;
    }

    functionName    = [NSString stringWithFormat:@"changeToViewState%@:", newState];
    if ([self respondsToSelector:NSSelectorFromString(functionName)] == YES)
    {
        [self performViewStateSelector:NSSelectorFromString(functionName) options:options];
        anyRun = YES;
    }

    if (!anyRun && completion)
    {
        completion(YES);
    }

    return;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)performViewStateSelector:(SEL)aSelector
                         options:(DNStateOptions*)options
{
    if (aSelector == nil)   {   return; }

    [self performSelector:aSelector withObject:options];
}

#pragma clang diagnostic pop

@end
