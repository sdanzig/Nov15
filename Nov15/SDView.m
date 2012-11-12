//
//  SDView.m
//  Nov15
//
//  Created by Scott Danzig on 11/11/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import "SDView.h"

#define NUM_OF_CELLS 10

@implementation SDView

- (id) initWithFrame: (CGRect) frame controller: (SDViewController *) c {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *colors = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor],[UIColor blueColor], nil];
		self.backgroundColor = [UIColor whiteColor];
		viewController = c;
        textViews = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i < NUM_OF_CELLS; i++) {
            CGFloat cellWidth = self.bounds.size.width;
            CGFloat cellHeight = self.bounds.size.height / NUM_OF_CELLS;
            CGFloat cellX = self.bounds.origin.x;
            CGFloat cellY = self.bounds.origin.y + (cellHeight * i);
            CGRect cellBounds = CGRectMake(cellX, cellY, cellWidth, cellHeight);
            UITextView *textView = [[UITextView alloc] initWithFrame: cellBounds];
			textView.editable = NO;
			textView.font = [UIFont fontWithName: @"Courier" 	size: 15];
            textView.backgroundColor = [colors objectAtIndex:i%[colors count]];
			[self addSubview: textView];
            [textViews addObject:textView];
        }
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for (int i = 0; i < [textViews count]; i++) {
        UITextView *tv = [textViews objectAtIndex:i];
        tv.text = [NSString stringWithFormat:@"test %d",i];
    }
}


@end
