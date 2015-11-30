//
//  ViewController.m
//  CircularTimerViewExample
//
//  Created by Ashiqur Rahman on 11/29/15.
//  Copyright © 2015 Ashiqur Rahman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timerView.timerDuration = 5.0f;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
