//
//  WelcomeScreenDemoAppDelegate.h
//  WelcomeScreenDemo
//
//  Created by Edward Rudd on 9/13/11.
//  Copyright 2011 OutOfOrder.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMWelcomeScreenController;

@interface WelcomeScreenDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) CMWelcomeScreenController *welcomeScreenController;

@end
