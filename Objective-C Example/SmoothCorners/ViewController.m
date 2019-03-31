//
//  ViewController.m
//  SmoothCorners
//
//  Created by Felix Lapalme on 2019-03-16.
//  Copyright © 2019 Felix Lapalme. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SmoothCorners.h"
#import "FLXSmoothView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *redView = [UIView new];
    UIView *yellowView = [UIView new];
    FLXSmoothView *blueView = [FLXSmoothView new];

    redView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.9];
    yellowView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.9];
    blueView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];

    redView.frame = CGRectInset(self.view.bounds, 20, 50);
    yellowView.frame = redView.frame;
    blueView.frame = redView.frame;

    [self.view addSubview:redView];
    [self.view addSubview:yellowView];
    [self.view addSubview:blueView];

    CGFloat radius = 90;

    // red view with regular corners
    redView.layer.cornerRadius = radius;

    // yellow view with smooth corners (using UIView category)
    yellowView.flx_continuousCorners = YES;
    yellowView.layer.cornerRadius = radius;

    // blue view (UIView subclass)
    blueView.flx_smoothCorners = YES;
    blueView.layer.cornerRadius = radius;

    UILabel *explanationLabel = [UILabel new];
    explanationLabel.frame = yellowView.frame;
    explanationLabel.numberOfLines = 0;
    explanationLabel.text = @"Red = regular rounded corners\nBeige = smooth rounded corners";
    [self.view addSubview:explanationLabel];
}

@end
