//
//  BlackRectangle.m
//  CameraTest
//
//  Created by Edward Rudd on 2/1/09.
//  Copyright 2009 OutOfOrder.cc. All rights reserved.
//

#import "BTRoundedView.h"

@implementation BTRoundedView

@synthesize borderRadius = _radius;
@synthesize fillcolor = _fillcolor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.opaque = NO;
		self.borderRadius = 20;
		self.fillcolor = [UIColor colorWithWhite:0.0 alpha:0.75];
    }
    return self;
}

- (void)awakeFromNib
{
	NSLog(@"Awake");
	self.opaque = NO;
	self.borderRadius = 20;
	self.fillcolor = [UIColor colorWithWhite:0.0 alpha:0.75];
	self.backgroundColor = [UIColor clearColor];
	[super awakeFromNib];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[_fillcolor setFill];
//w	[_fillcolor setStroke];
//	CGContextSetRGBFillColor(context, _fillcolor, 0, 0, 0.75);
//	CGContextSetRGBStrokeColor(context, 1, 1, 1, 0.0);
	CGRect rrect = self.bounds;
	CGFloat rradius = _radius;
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);

	if (rradius > (rrect.size.width / 2)) {
		rradius = rrect.size.width / 2;
	}
	if (rradius > (rrect.size.height / 2)) {
		rradius = rrect.size.height / 2;
	}
	
	// Start at 1
	CGContextMoveToPoint(context, minx, midy);
	// Add an arc through 2 to 3
	CGContextAddArcToPoint(context, minx, miny, midx, miny, rradius);
	// Add an arc through 4 to 5
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, rradius);
	// Add an arc through 6 to 7
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, rradius);
	// Add an arc through 8 to 9
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, rradius);
	// Close the path
	CGContextClosePath(context);
	// Fill & stroke the path
	CGContextDrawPath(context, kCGPathFill);	
}


- (void)dealloc {
    [_fillcolor release];
    [super dealloc];
}


@end
