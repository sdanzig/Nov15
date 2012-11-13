//
//  SDViewController.h
//  Nov15
//
//  Created by Scott Danzig on 11/11/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDViewController : UIViewController {
    NSMutableArray *textViews;
    UITextView *draggedTextView;
    int origViewPos;
    int newViewPos;
    BOOL animating;
    UIColor *oldColor;
}

@end
