//
//  BTViewUtils.h
//  BananaTouch
//
//  Created by Edward Rudd on 1/2/09.
//  Copyright 2009 OutOfOrder.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTViewUtils : NSObject {

}

+(void)decomposeView:(UIView *)view withIndent:(int)indent;
+(void)decomposeViewController:(UIViewController *)viewController;
+(UIView *)findSubViewByClassName:(NSString *)name UsingView: (UIView *)view;

@end
