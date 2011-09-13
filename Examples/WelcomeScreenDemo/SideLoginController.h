//
//  SideLoginController.h
//  BananaTouch
//
//  Created by Edward Rudd on 9/13/11.
//  Copyright 2011 OutOfOrder.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "CMWelcomeScreenController.h"

@interface SideLoginController : UIViewController <CMSideViewController> {
    
}

@property (nonatomic, retain) CMWelcomeScreenController *welcomeScreenController;

- (IBAction) doLogin;

@end
