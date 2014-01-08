//
//  KIViewController.m
//  AutoLayoutDemo
//
//  Created by Collin Beck on 1/8/14.
//  Copyright (c) 2014 Koedal, Inc. All rights reserved.
//

#import "KIViewController.h"
#import "KIAutoResizingMaskViewController.h"

@interface KIViewController ()

@end

@implementation KIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Menu";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectAutoResizeButton:(id)sender {
    UIViewController *resizeViewController = [[KIAutoResizingMaskViewController alloc] initWithNibName:@"KIAutoResizingMaskViewController" bundle:nil];
    [self.navigationController pushViewController:resizeViewController animated:YES];
}

@end
