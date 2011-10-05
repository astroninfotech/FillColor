//
//  FillColorAppDelegate.h
//  FillColor
//
//  Created by Astron Infotech on 03/05/2010.
//  Copyright Astron Infotech 2011. All rights reserved.

#import <UIKit/UIKit.h>

@class FillColorViewController;

@interface FillColorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FillColorViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FillColorViewController *viewController;

@end

