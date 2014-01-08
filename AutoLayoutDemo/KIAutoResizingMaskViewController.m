//
//  KIAutoResizingMaskViewController.m
//  AutoLayoutDemo
//
//  Created by Collin Beck on 1/8/14.
//  Copyright (c) 2014 Koedal, Inc. All rights reserved.
//

#import "KIAutoResizingMaskViewController.h"

@interface KIAutoResizingMaskViewController () {
    CGRect portraitStarOneFrame;
    CGRect portraitStarTwoFrame;
    CGRect portraitStarThreeFrame;
    
    CGRect landscapeStarOneFrame;
    CGRect landscapeStarTwoFrame;
    CGRect landscapeStarThreeFrame;
}
@property (weak, nonatomic) IBOutlet UIView *starOne;
@property (weak, nonatomic) IBOutlet UIView *starTwo;
@property (weak, nonatomic) IBOutlet UIView *starThree;

@end

@implementation KIAutoResizingMaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupFrames];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self applyFramesForOrientation:orientation];
}

- (IBAction)didSelectMenuButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupFrames
{
    // Using frames instead of center points here because I'll need to change the size of the stars as well
    // when I handle the smaller screen sizes
    portraitStarOneFrame = self.starOne.frame;
    portraitStarTwoFrame = self.starTwo.frame;
    portraitStarThreeFrame = self.starThree.frame;
    
    CGFloat landscapeStarOneX = 30;
    CGFloat landscapeStarY = 20;
    CGFloat landscapeStarPadding = 20;
    
    landscapeStarOneFrame = CGRectMake(landscapeStarOneX, landscapeStarY, portraitStarOneFrame.size.width, portraitStarOneFrame.size.height);
    landscapeStarTwoFrame = CGRectMake(landscapeStarOneX + portraitStarOneFrame.size.width + landscapeStarPadding, landscapeStarY, portraitStarTwoFrame.size.width, portraitStarTwoFrame.size.height);
    landscapeStarThreeFrame = CGRectMake(landscapeStarTwoFrame.origin.x + landscapeStarTwoFrame.size.width + landscapeStarPadding, landscapeStarY, portraitStarThreeFrame.size.width, portraitStarThreeFrame.size.height);
}

- (void)applyFramesForOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    // Get Center Y
    CGFloat centerY = self.view.center.y;
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.starOne.frame = landscapeStarOneFrame;
        self.starTwo.frame = landscapeStarTwoFrame;
        self.starThree.frame = landscapeStarThreeFrame;
        
        CGPoint starOneCenter = self.starOne.center;
        starOneCenter.y = centerY;
        self.starOne.center = starOneCenter;
        
        CGPoint starTwoCenter = self.starTwo.center;
        starTwoCenter.y = centerY;
        self.starTwo.center = starTwoCenter;
        
        CGPoint starThreeCenter = self.starThree.center;
        starThreeCenter.y = centerY;
        self.starThree.center = starThreeCenter;
        
    } else {
        self.starOne.frame = portraitStarOneFrame;
        self.starTwo.frame = portraitStarTwoFrame;
        self.starThree.frame = portraitStarThreeFrame;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self applyFramesForOrientation:toInterfaceOrientation];
}

@end
