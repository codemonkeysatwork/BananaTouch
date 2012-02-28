//
//  BTDismissPopoverDelegate.h
//  BananaTouch
//
//  Created by Edward Rudd on 2/28/2012.
//  Copyright 2012 OutOfOrder.cc. All rights reserved.
//

@protocol BTDismissPopoverDelegate
@required
- (void) dismissPopoverAnimated:(BOOL)animated withData:(id)data;
@end