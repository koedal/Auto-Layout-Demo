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

- (IBAction)didSelectMenuButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didSelectAnimate:(id)sender {
    CGAffineTransform scale = CGAffineTransformMakeScale(1.5f, 1.5f);
    
    NSTimeInterval duration = 0.33;
    
    NSArray *stars = @[self.oneStar, self.twoStar, self.threeStar];
        
    for (int i = 0; i < stars.count; i++) {
        UIView *star = stars[i];
        
        [UIView animateWithDuration:duration
                              delay:0.25 * i
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             star.transform = scale;
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:duration animations:^{
                                 star.transform = CGAffineTransformIdentity;
                             }];
                         }];
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


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self applyConstraintsForOrientation:toInterfaceOrientation];
}
@end
