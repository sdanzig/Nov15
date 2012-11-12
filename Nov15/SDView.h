//
//  SDView.h
//  Nov15
//
//  Created by Scott Danzig on 11/11/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDViewController;

@interface SDView : UIView {
	SDViewController *viewController;
	NSMutableArray *textViews;
}

- (id) initWithFrame: (CGRect) frame controller: (SDViewController *) c;

@end
