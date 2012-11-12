//
//  SDViewController.m
//  Nov15
//
//  Created by Scott Danzig on 11/11/12.
//  Copyright (c) 2012 Scott Danzig. All rights reserved.
//

#import "SDViewController.h"
#import "SDView.h"

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
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	self.view = [[SDView alloc] initWithFrame: frame controller: self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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


@end
