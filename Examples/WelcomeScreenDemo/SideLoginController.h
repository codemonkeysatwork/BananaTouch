//
//  SideLoginController.h
//  BananaTouch
//
//  Created by Edward Rudd on 9/13/11.
//  Copyright 2011 OutOfOrder.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "BTWelcomeScreenController.h"

@interface SideLoginController : UIViewController <BTSideViewController> {
    
}

@property (nonatomic, retain) BTWelcomeScreenController *welcomeScreenController;

- (IBAction) doLogin;

@end
