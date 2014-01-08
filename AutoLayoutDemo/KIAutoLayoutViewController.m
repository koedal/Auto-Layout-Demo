//
//  KIAutoLayoutViewController.m
//  AutoLayoutDemo
//
//  Created by Collin Beck on 1/8/14.
//  Copyright (c) 2014 Koedal, Inc. All rights reserved.
//

#import "KIAutoLayoutViewController.h"

@interface KIAutoLayoutViewController ()
@property (weak, nonatomic) IBOutlet UIView *oneStar;
@property (weak, nonatomic) IBOutlet UIView *twoStar;
@property (weak, nonatomic) IBOutlet UIView *threeStar;
@property (weak, nonatomic) IBOutlet UIButton *animateButton;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *portraitConstraints;
@property (strong, nonatomic) NSArray *landscapeConstraints;
@end

@implementation KIAutoLayoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self applyConstraintsForOrientation:orientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectMenuButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)applyConstraintsForOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        [self.view removeConstraints:self.portraitConstraints];
        [self.view addConstraints:self.landscapeConstraints];
    } else {
        [self.view removeConstraints:self.landscapeConstraints];
        [self.view addConstraints:self.portraitConstraints];
    }

}

- (void)setupConstraints
{
    // Landscape Constraints
    id oneStar = self.oneStar;
    id twoStar = self.twoStar;
    id threeStar = self.threeStar;
    id animateButton = self.animateButton;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(oneStar, twoStar, threeStar, animateButton);
    
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:3];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[oneStar]-[twoStar]-[threeStar]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    
    // Position the animate button
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[animateButton]-|" options:0 metrics:nil views:views]];
    
    NSLayoutConstraint *centerXAnimateConstraint = [NSLayoutConstraint constraintWithItem:self.animateButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:twoStar attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    [constraints addObject:centerXAnimateConstraint];
    
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:twoStar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:twoStar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [constraints addObject:centerYConstraint];
    [constraints addObject:centerXConstraint];
    self.landscapeConstraints = [constraints copy];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
    
    [self applyConstraintsForOrientation:interfaceOrientation];
}
@end
