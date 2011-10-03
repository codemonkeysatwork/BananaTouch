//
//  WelcomeScreenController.h
//  FlightBag
//
//  Created by Edward Rudd on 6/22/11.
//  Copyright 2011 OutOfOrder.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BTSideViewController;

@interface BTWelcomeScreenController : UIViewController {
}

@property (nonatomic, retain) UIViewController<BTSideViewController> *sideViewController;
@property (nonatomic, assign) BOOL animateSideView;
@property (nonatomic, retain, readonly) UIImageView *logoImage;

- (id)initWithSideController: (UIViewController<BTSideViewController> *)sideController;
- (id)initWithSideController: (UIViewController<BTSideViewController> *)sideController animated:(BOOL)animated;

- (void)dismiss;
- (void)wobbleSideViewController;

@end

@protocol BTSideViewController <NSObject>
@required
- (void)setWelcomeScreenController:(BTWelcomeScreenController *)controller;
@optional
- (void)sideController:(id<BTSideViewController>)sideController didAppearAnimated:(BOOL)animated;
@end
