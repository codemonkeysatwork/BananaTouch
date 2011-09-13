//
//  WelcomeScreenController.h
//  FlightBag
//
//  Created by Edward Rudd on 6/22/11.
//  Copyright 2011 OutOfOrder.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMSideViewController;

@interface CMWelcomeScreenController : UIViewController {
}

@property (nonatomic, retain) UIViewController<CMSideViewController> *sideViewController;
@property (nonatomic, assign) BOOL animateSideView;
@property (nonatomic, retain, readonly) UIImageView *logoImage;

- (id)initWithSideController: (UIViewController<CMSideViewController> *)sideController;
- (id)initWithSideController: (UIViewController<CMSideViewController> *)sideController animated:(BOOL)animated;

- (void)dismiss;
- (void)wobbleSideViewController;

@end

@protocol CMSideViewController <NSObject>
@required
- (void)setWelcomeScreenController:(CMWelcomeScreenController *)controller;
@optional
- (void)sideController:(id<CMSideViewController>)sideController didAppearAnimated:(BOOL)animated;
@end
