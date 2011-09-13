//
//  WelcomeScreenController.m
//  FlightBag
//
//  Created by Edward Rudd on 6/22/11.
//  Copyright 2011 OutOfOrder.cc. All rights reserved.
//

#import "CMWelcomeScreenController.h"
#import "CMGradientView.h"
#import <QuartzCore/QuartzCore.h>

@interface CMWelcomeScreenController()
@property (nonatomic, retain) UIView* wrapperView;
@property (nonatomic, assign) BOOL keyboardVisible;
- (void)showSideScreen;
@end

@implementation CMWelcomeScreenController

@synthesize sideViewController = _sideViewController;
@synthesize logoImage = _logoImage;
@synthesize animateSideView = _animateSideView;

@synthesize wrapperView = _wrapperView;
@synthesize keyboardVisible = _keyboardVisible;

#define kImageHeight 320
#define kImageWidth 320
#define kSideFrameWidth 320

#pragma mark - Properties

- (void)setSideViewController:(UIViewController *)sideViewController
{
    if (_sideViewController.view.superview) {
        [_sideViewController.view removeFromSuperview];
    }
    [_sideViewController release];
    _sideViewController = [sideViewController retain];
    // @todo add in call to central layout method
}

- (UIImageView *)logoImage
{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImageWidth, kImageHeight)];
        _logoImage.contentMode = UIViewContentModeScaleAspectFit;
        _logoImage.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin
                                        | UIViewAutoresizingFlexibleTopMargin
                                        | UIViewAutoresizingFlexibleLeftMargin
                                        | UIViewAutoresizingFlexibleRightMargin;
    }
    return _logoImage;
}

#pragma mark - Memory Management

- (id)initWithSideController: (UIViewController<CMSideViewController> *)sideController
{
    return [self initWithSideController:sideController animated:YES];
}

- (id)initWithSideController:(UIViewController<CMSideViewController> *)sideController animated:(BOOL)animated
{
    self = [super init];
    if (self) {
        self.sideViewController = sideController;
        _keyboardVisible = NO;
        _animateSideView = animated;
    }
    return self;
}

- (void)dealloc
{
    [_sideViewController release];
    [_logoImage release];
    [_wrapperView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[_sideViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[_sideViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                                    duration:(NSTimeInterval)duration
{
    [_sideViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

    if (_sideViewController.view.superview) {
        CGRect screen = _wrapperView.bounds;
        CGRect imageFrame = _logoImage.frame;

        CGRect sideFrame = CGRectMake(screen.size.width / 2,
                                      (screen.size.height - imageFrame.size.height) / 2,
                                      kSideFrameWidth,
                                      imageFrame.size.height);
        _sideViewController.view.frame = sideFrame;

        imageFrame.origin.x = ((screen.size.width / 2) - imageFrame.size.width) - 20;
        _logoImage.frame = imageFrame;
    }
}

- (void)loadView
{
    CGSize screen = [[UIScreen mainScreen] applicationFrame].size;

    CMGradientView *main = [[CMGradientView alloc] initWithFrame:CGRectMake(0, 0, screen.width, screen.height)];
    main.colors = [NSArray arrayWithObjects:(id)[[UIColor grayColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    main.backgroundColor = [UIColor greenColor];

    self.view = main;
    [main release];

    _wrapperView = [[UIView alloc] initWithFrame: CGRectMake(0, (screen.height - kImageHeight) / 2, screen.width, kImageHeight)];
    _wrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleTopMargin
                                    | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_wrapperView];

    CGRect logoFrame = CGRectMake((screen.width - kImageWidth) / 2, 0, kImageWidth, kImageHeight);
    self.logoImage.frame = logoFrame;

    [_wrapperView addSubview:self.logoImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_animateSideView) {
        [self showSideScreen];
    }
}

- (void)viewDidUnload
{
    [_logoImage release];
    _logoImage = nil;
    [_wrapperView release];
    _wrapperView = nil;
    [super viewDidUnload];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_animateSideView) {
        [self performSelector:@selector(showSideScreen) withObject:nil afterDelay:1.0];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Keyboard handling

- (void)keyboardShow:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];

    CGRect kbRectSrc = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect kbRect = [self.view convertRect:kbRectSrc toView:nil];
    CGRect screen = self.view.bounds;
    CGRect frame = _wrapperView.frame;

    CGFloat newValue = screen.size.height - kbRect.size.height - frame.size.height - 20;
    CGFloat midValue = (screen.size.height - frame.size.height) / 2;

    frame.origin.y = newValue > midValue ? midValue : newValue;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    [UIView setAnimationCurve:[[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];

    _wrapperView.frame = frame;

    [UIView commitAnimations];

    _keyboardVisible = YES;
}

- (void)keyboardHide:(NSNotification *)notif
{
    CGRect screen = self.view.bounds;
    CGRect frame = _wrapperView.frame;

    frame.origin.y = (screen.size.height - frame.size.height) / 2;

    [UIView beginAnimations:nil context:NULL];

    _wrapperView.frame = frame;

    [UIView commitAnimations];

    _keyboardVisible = NO;
}

#pragma mark - SubScreen

- (void)showSideScreen
{
    CGRect screen = _wrapperView.bounds;
    CGRect imageFrame = _logoImage.frame;

    CGRect sideFrame = CGRectMake(screen.size.width,
                                  (screen.size.height - imageFrame.size.height) / 2,
                                  kSideFrameWidth,
                                  imageFrame.size.height);
    UIView *theView = _sideViewController.view;
    theView.frame = sideFrame;
    if (!theView.superview) {
        [_sideViewController viewWillAppear:NO];
        [_wrapperView addSubview:theView];
        // Evil Kludge due to apple oversight to set the child viewcontroller's parent setting
        [_sideViewController setWelcomeScreenController:self];
//        [_sideViewController setValue:self forKey:@"_parentViewController"];

        [_sideViewController viewDidAppear:NO];
    }

    imageFrame.origin.x = ((screen.size.width / 2) - imageFrame.size.width) - 20;
    sideFrame.origin.x = screen.size.width / 2;

    void (^movelogoblock)(void) = ^{
        _logoImage.frame = imageFrame;
        _sideViewController.view.frame = sideFrame;
    };

    void (^completelogoblock)(BOOL) = ^(BOOL finished){
        if ([_sideViewController respondsToSelector:@selector(sideController:didAppearAnimated:)]) {
            [_sideViewController sideController:_sideViewController didAppearAnimated: _animateSideView];
        }
    };

    if (_animateSideView) {
        [UIView animateWithDuration:0.7 animations:movelogoblock completion:completelogoblock];
    } else {
        movelogoblock();
        completelogoblock(YES);
    }
}

#pragma mark - Actions
- (void)dismiss
{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark - Side View Animation Effects

- (void)wobbleSideViewController
{
    CGRect rect = self.sideViewController.view.frame;

    CGFloat x = rect.size.width / 2 + rect.origin.x;
    CGFloat y = rect.size.height / 2 + rect.origin.y;
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, x, y);
    CGPathAddLineToPoint(thePath, NULL, x - 20, y);
    CGPathAddLineToPoint(thePath, NULL, x + 15, y);
    CGPathAddLineToPoint(thePath, NULL, x - 10, y);
    CGPathAddLineToPoint(thePath, NULL, x +  5, y);
    CGPathAddLineToPoint(thePath, NULL, x, y);

    CAKeyframeAnimation *theAnimation;
    theAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    theAnimation.path = thePath;
    theAnimation.duration = 1;
    theAnimation.repeatCount = 1;
    CFRelease(thePath);

    [self.sideViewController.view.layer addAnimation:theAnimation forKey:@"wobble"];
}


@end
