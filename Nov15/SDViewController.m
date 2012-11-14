//
//  SDViewController.m
//  Nov15
//
//  Created by Scott Danzig on 11/11/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import "SDViewController.h"
#import "SDView.h"

#define NUM_OF_CELLS 10
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface SDViewController ()

@end

@implementation SDViewController
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
- (void) loadView {
    newViewPos = -1;
    animating = NO;
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	self.view = [[SDView alloc] initWithFrame: frame controller: self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *colors = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor],[UIColor blueColor], nil];
    textViews = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < NUM_OF_CELLS; i++) {
        CGFloat cellWidth = self.view.bounds.size.width;
        CGFloat cellHeight = self.view.bounds.size.height / NUM_OF_CELLS;
        CGFloat cellX = self.view.bounds.origin.x;
        CGFloat cellY = self.view.bounds.origin.y + (cellHeight * i);
        CGRect cellBounds = CGRectMake(cellX, cellY, cellWidth, cellHeight);
        UITextView *textView = [[UITextView alloc] initWithFrame: cellBounds];
        textView.editable = NO;
        textView.font = [UIFont fontWithName: @"Courier" 	size: 15];
        textView.backgroundColor = [colors objectAtIndex:i%[colors count]];
        textView.userInteractionEnabled = NO;
        [self.view addSubview: textView];
        [textViews addObject:textView];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (int i = 0; i < [textViews count]; i++) {
        UITextView *tv = [textViews objectAtIndex:i];
        tv.text = [NSString stringWithFormat:@"Drag me! - %d",i];
    }
    //[self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
	// Return YES for supported orientations
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;	//allow every interface orientation
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i = 0; i < [textViews count]; i++) {
        UITextView *tv = [textViews objectAtIndex:i];
        CGPoint point = [[touches anyObject] locationInView:self.view];
        if(CGRectContainsPoint(tv.frame, point)) {
            draggedTextView = tv;
            origViewPos = i;
            newViewPos = i;
            oldColor = draggedTextView.backgroundColor;
            break;
        }
    }
    [self setColorOfDraggedView:[UIColor yellowColor]];
//    [self flipColorOfDraggedView];
}
/*
- (void) flipColorOfDraggedView
{
    NSLog(@"In flipColorOfDraggedView for viewController");
//    UIColor *oldColor = draggedTextView.backgroundColor;
//    CGColorRef tmpColor = [oldColor CGColor];
//    CGFloat newComponents[4] = {};
//    memcpy(newComponents, CGColorGetComponents(tmpColor), sizeof(newComponents));
    
    const CGFloat *componentColors = CGColorGetComponents([oldColor CGColor]);
    
    UIColor *newColor = [[UIColor alloc] initWithRed:(255 - componentColors[0])
                                               green:(255 - componentColors[1])
                                                blue:(255 - componentColors[2])
                                               alpha:componentColors[3]];
    draggedTextView.backgroundColor = newColor;
//    draggedTextView.backgroundColor = [UIColor yellowColor];
}
*/
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CGPoint newCenter = CGPointMake(self.view.center.x, point.y);
    [self.view bringSubviewToFront:draggedTextView];
    draggedTextView.center = newCenter;
    for (int i = 0; i < [textViews count]; i++) {
        UITextView *tv = [textViews objectAtIndex:i];
        if(CGRectContainsPoint(tv.frame, point) && (i != newViewPos)) {
            UITextView *tvBeingMoved = [textViews objectAtIndex:i];
            CGRect tvFrame = tvBeingMoved.frame;
            if(i > newViewPos) {
                // Move [textViews objectAtIndex:i] up
                tvFrame.origin.y -= tvFrame.size.height * (i-newViewPos);
            } else { // i < newViewPos
                // Move [textViews objectAtIndex:i] down
                tvFrame.origin.y += tvFrame.size.height * (newViewPos-i);
            }
            [UIView beginAnimations: nil context: NULL];
            
			//Describe the animation itself.
			[UIView setAnimationDuration: 1.0];	//in seconds; default is 0.2
			[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
			[UIView setAnimationRepeatCount: 1.0];	//The default is 1.0.
            
			//Describe what the animation should do.
            tvBeingMoved.frame = tvFrame;
            int randNum = rand() % 20; //create the random number.
            randNum -= 10;
            tvBeingMoved.transform = CGAffineTransformRotate(tvBeingMoved.transform, DEGREES_TO_RADIANS(-randNum));
            tvBeingMoved.transform = CGAffineTransformRotate(tvBeingMoved.transform, DEGREES_TO_RADIANS(randNum));
            
            [UIView commitAnimations];

            [textViews setObject:[textViews objectAtIndex:i] atIndexedSubscript:newViewPos];
            [textViews setObject:draggedTextView atIndexedSubscript:i];
            newViewPos = i;
//            break;
        }
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    if(newViewPos != -1) {
        CGFloat cellHeight = self.view.bounds.size.height / NUM_OF_CELLS;
        CGFloat cellY = self.view.bounds.origin.y + (cellHeight * newViewPos);
        CGRect tvFrame = draggedTextView.frame;
        tvFrame.origin.y = cellY;
        draggedTextView.frame = tvFrame;
        newViewPos = -1;
    }
    [self setColorOfDraggedView:oldColor];
    draggedTextView = NULL;
    [self.view setNeedsDisplay];
}

- (void) setColorOfDraggedView: (UIColor *)color
{
    [UIView beginAnimations: nil context: NULL];
    
    //Describe the animation itself.
    [UIView setAnimationDuration: 1.0];	//in seconds; default is 0.2
    [UIView setAnimationCurve: UIViewAnimationOptionCurveEaseIn];
    [UIView setAnimationRepeatCount: 1.0];	//The default is 1.0.
    
    //Describe what the animation should do.
    draggedTextView.backgroundColor = color;
    
    [UIView commitAnimations];

}

@end