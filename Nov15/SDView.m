//
//  SDView.m
//  Nov15
//
//  Created by Scott Danzig on 11/11/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import "SDView.h"
#import "SDViewController.h"

@implementation SDView

- (id) initWithFrame: (CGRect) frame controller: (SDViewController *) c {
    self = [super initWithFrame:frame];
    viewController = c;
    if (self) {
		self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    [viewController touchesBegan:touches withEvent:event];
}

- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event {
    
    [viewController touchesMoved:touches withEvent:event];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    [viewController touchesEnded:touches withEvent:event];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
}
*/

@end
