//
//  ViewController.m
//  SunShineBtn
//
//  Created by 白衣卿相 on 2017/3/29.
//  Copyright © 2017年 白衣卿相. All rights reserved.
//

#import "ViewController.h"

#import "BtnBackgroundView.h"

#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong)NSMutableArray * shapeAry;
@property (nonatomic, strong)UIView  * demoVeiw;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BtnBackgroundView * btnView = [[BtnBackgroundView alloc] initWithFrame:CGRectMake(0, 200, kSCREEN_WIDTH, 200)];
    [self.view addSubview:btnView];
    
}


@end
