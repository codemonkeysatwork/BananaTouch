//
//  BTGradientView.m
//  BananaTouch
//
//  Created by Edward Rudd on 8/31/11.
//  Copyright 2011 OutOfOrder.cc. All rights reserved.
//

#import "BTGradientView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BTGradientView

@dynamic stops;
@dynamic colors;

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Gradient Property Access

- (NSArray *)stops
{
    return [(CAGradientLayer *)self.layer locations];
}

-(void)setStops:(NSArray *)stops
{
    [(CAGradientLayer *)self.layer setLocations:stops];
}

- (NSArray *)colors
{
    return [(CAGradientLayer *)self.layer colors];
}

-(void)setColors:(NSArray *)colors
{
    [(CAGradientLayer *)self.layer setColors:colors];
}

@end
