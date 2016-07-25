//
//  ViewController2.m
//  VideoTransition
//
//  Created by annidyfeng on 16/7/21.
//  Copyright © 2016年 annidyfeng. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.delegate = self;
    self.navigationController.navigationBar.hidden = NO;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    self.animationController.reverse = YES;
    return self.animationController;
}
@end
