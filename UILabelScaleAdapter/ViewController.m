//
//  ViewController.m
//  UILabelScaleAdapter
//
//  Created by 田淳 on 2019/7/6.
//  Copyright © 2019 田淳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * label = [UILabel new];
    label.text = @"Label-system";
    label.font = [UIFont systemFontOfSize:17];
    label.frame = CGRectMake(0, 40, 200, 30);
    [self.view addSubview:label];
    
    UILabel * label1 = [UILabel new];
    label1.text = @"Label-PingFangSC-Regular";
    label1.font = [UIFont fontWithName:@"PingFangSC" size:17];
    label1.frame = CGRectMake(0, 70, 200, 30);
    [self.view addSubview:label1];
}


@end
