//
//  ViewController.m
//  Animations
//
//  Created by Alexey Baryshnikov on 27.05.2020.
//  Copyright © 2020 Alexey Baryshnikov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//@property (nonatomic, weak)UIView *testView;
@property (nonatomic, weak)UIImageView *testImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *img1 = [UIImage imageNamed:@"1.png"];
    UIImage *img2 = [UIImage imageNamed:@"2.png"];
    UIImage *img3 = [UIImage imageNamed:@"3.png"];
    NSArray *images = [NSArray arrayWithObjects:img1, img2, img3, img2, nil];
    
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.backgroundColor = [UIColor systemPinkColor];
//    view.layer.cornerRadius = 12.f;
    view.animationImages = images;
    view.animationDuration = 1;
    [view startAnimating];
    [self.view addSubview:view];
    self.testImageView = view;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
//    [UIView animateWithDuration:3 animations:^{
//        self.testView.backgroundColor = [UIColor greenColor];
//        self.testView.layer.cornerRadius = 50.f;
//        self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, 150);
//    }];
//    [UIView animateWithDuration:3 animations:^{
//        self.testView.backgroundColor = [UIColor greenColor];
//        self.testView.layer.cornerRadius = 50.f;
//        self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, 150);
//    } completion:^(BOOL finished) {
//        NSLog(@"%d", finished);
//    }];
    
    
//    double delayInSeconds = 6;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
//        [self.testView.layer removeAllAnimations];
//    });

    [self moveView:self.testImageView];
    
}

- (void)moveView:(UIView *)view {
    CGRect rect = self.view.bounds;
    
    rect = CGRectInset(rect, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    CGFloat x = arc4random() % (int)CGRectGetWidth(rect) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % (int)CGRectGetHeight(rect) + CGRectGetMinY(rect);
    CGFloat s = (float)(arc4random() % 151) / 100.f + 0.5f;
    CGFloat r = (float)(arc4random() % (int)(M_PI * 2 * 10000)) / 10000 - M_PI;
    CGFloat d = (float)(arc4random() % 2001) / 1000 + 2;
    
    [UIView animateWithDuration:d
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        view.backgroundColor = [self randomColor];
        
        view.layer.cornerRadius = 50.f;
        view.center = CGPointMake(x, y);
        
        CGAffineTransform rotation = CGAffineTransformMakeRotation(r);
        CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
        CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
        
        view.transform = transform;
    }
                     completion:^(BOOL finished) {
        NSLog(@"%@", finished ? @"Good" : @"Bad");
        NSLog(@"\nview frame = %@\nview bounds = %@", NSStringFromCGRect(view.frame), NSStringFromCGRect(view.bounds));
        __weak UIView *v = view;
        [self moveView:v];
    }];
}

- (float)randomFloatFromZeroToOne {
    return (float)(arc4random() % 256) / 255;
}

- (UIColor *)randomColor {
    CGFloat r = [self randomFloatFromZeroToOne];
    CGFloat g = [self randomFloatFromZeroToOne];
    CGFloat b = [self randomFloatFromZeroToOne];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
