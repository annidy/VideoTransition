//
//  VideoAnimationController.m
//  VideoTransition
//
//  Created by annidyfeng on 16/7/21.
//  Copyright © 2016年 annidyfeng. All rights reserved.
//

#import "VideoAnimationController.h"
#include "ViewController.h"
#include "ViewController2.h"

@implementation VideoAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    if(self.reverse){
        [self executeReverseAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    } else {
        [self executeForwardsAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
}

- (void)executeForwardsAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView
{
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromView];
    toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
    [containerView addSubview:toView];
    [containerView addSubview:self.previewView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toView.frame = containerView.frame;
                         fromView.frame = CGRectOffset(fromView.frame, -fromView.frame.size.width, 0);
                         
                         CGAffineTransform transform = CGAffineTransformMakeScale(0.3, 0.3);
                         self.previewView.transform = transform;
                     }
                     completion:^(BOOL finished) {
                         // remove all the temporary views
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView
{
    UIView *containerView = [transitionContext containerView];

    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:fromView];
    [containerView sendSubviewToBack:toView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toView.frame = containerView.frame;
                         fromView.frame = CGRectOffset(fromView.frame, fromView.frame.size.width, 0);
                         
                         self.previewView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [toView addSubview:self.previewView];
                         [toView sendSubviewToBack:self.previewView];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}
@end
