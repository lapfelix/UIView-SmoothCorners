//
//  ViewController.m
//  SmoothCorners
//
//  Created by Felix Lapalme on 2019-03-16.
//  Copyright © 2019 Felix Lapalme. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SmoothCorners.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *redView = [UIView new];
    UIView *yellowView = [UIView new];

    redView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.9];
    yellowView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.9];

    redView.frame = CGRectInset(self.view.bounds, 20, 50);
    yellowView.frame = redView.frame;

    [self.view addSubview:redView];
    [self.view addSubview:yellowView];

    CGFloat radius = 90;

    // red view with regular corners
    redView.layer.cornerRadius = radius;

    // yellow view with smooth corners
    yellowView.flx_continuousCorners = YES;
    yellowView.layer.cornerRadius = radius;

    UILabel *explanationLabel = [UILabel new];
    explanationLabel.frame = yellowView.frame;
    explanationLabel.numberOfLines = 0;
    explanationLabel.text = @"Red = regular rounded corners\nYellow = smooth rounded corners";
    [self.view addSubview:explanationLabel];
}

@end
