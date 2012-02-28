//
//  BTViewUtils.m
//  BananaTouch
//
//  Created by Edward Rudd on 1/2/09.
//  Copyright 2009 OutOfOrder.cc. All rights reserved.
//

#import "BTViewUtils.h"

@implementation BTViewUtils

+(void)decomposeView:(UIView *)view withIndent:(int)indent
{
#if defined(DEBUG)
	NSString *nstr = [NSString stringWithFormat:@"%%-%ds- %%@  (T:%%x %%.0fx%%.0f+%%.0fx%%.0f)", indent];
	NSLog(nstr, "", view, view.tag,
				view.frame.size.width, view.frame.size.height,
				view.frame.origin.x,view.frame.origin.y);
	for (UIView *tView in view.subviews) {
		[self decomposeView:tView withIndent:indent+2 ];
	}
#endif
}

+(void)decomposeViewController:(UIViewController *)viewController
{
#if defined(DEBUG)
	NSLog(@"Decomposing %@", viewController);
	[self decomposeView: viewController.view withIndent:2];
#endif
}

+(UIView *)findSubViewByClassName:(NSString *)name UsingView: (UIView *)view
{
	@try {
		NSString *temp = NSStringFromClass([view class]);
//		NSLog(@"Checking %@ against %@", temp, name);
		if ([name isEqualToString:temp]) {
			return view;
		}
	}
	@catch (NSException *exception) {
		NSLog(@"Checking Short String against %@", name);
	}
	for (UIView *temp in view.subviews) {
		temp = [self findSubViewByClassName:name UsingView:temp];
		if (temp != nil) {
			return temp;
		}
	}
	return nil;
}

@end
