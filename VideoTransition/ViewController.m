//
//  ViewController.m
//  VideoTransition
//
//  Created by annidyfeng on 16/7/20.
//  Copyright © 2016年 annidyfeng. All rights reserved.
//

#import "ViewController.h"
#import "VideoAnimationController.h"
#import "ViewController2.h"
@import AVFoundation;

@interface ViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDevice *videoCaptureDevice;
@property (strong, nonatomic) AVCaptureDevice *audioCaptureDevice;
@property (strong, nonatomic) AVCaptureDeviceInput *videoDeviceInput;
@property (strong, nonatomic) AVCaptureDeviceInput *audioDeviceInput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property VideoAnimationController *animationController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animationController = [[VideoAnimationController alloc] init];
    self.previewView = ({
        UIView *view = [UIView new];
        [self.view addSubview:view];
        [self.view sendSubviewToBack:view];
        view.layer.anchorPoint = CGPointMake(1, 1);
        view.frame = self.view.bounds;
        view;
    });
    self.animationController.previewView = self.previewView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.delegate = self;
    self.navigationController.navigationBar.hidden = YES;
    [self initialize];

}

- (void)initialize
{
    if(!_session) {
        _session = [[AVCaptureSession alloc] init];
        
        // preview layer
        CGRect bounds = self.previewView.layer.bounds;
        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _captureVideoPreviewLayer.bounds = bounds;
        _captureVideoPreviewLayer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
        [self.previewView.layer addSublayer:_captureVideoPreviewLayer];
        

        self.videoCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
 
        
        NSError *error = nil;
        _videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_videoCaptureDevice error:&error];
        
        if (!_videoDeviceInput) {
            return;
        }
        
        if([self.session canAddInput:_videoDeviceInput]) {
            [self.session  addInput:_videoDeviceInput];
        }
        
    }
    
    //if we had disabled the connection on capture, re-enable it
    if (![self.captureVideoPreviewLayer.connection isEnabled]) {
        [self.captureVideoPreviewLayer.connection setEnabled:YES];
    }
    
    [self.session startRunning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController2 *vc = (ViewController2 *) [segue destinationViewController];
    vc.animationController = self.animationController;
}

- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    self.animationController.reverse = NO;
    return self.animationController;
}
@end
