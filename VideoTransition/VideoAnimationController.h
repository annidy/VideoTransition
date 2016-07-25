//
//  VideoAnimationController.h
//  VideoTransition
//
//  Created by annidyfeng on 16/7/21.
//  Copyright © 2016年 annidyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VideoAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL reverse;
@property UIView *previewView;

@end
