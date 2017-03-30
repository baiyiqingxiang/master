//
//  SunShineBtnLayer.h
//  SunShineBtn
//
//  Created by 白衣卿相 on 2017/3/29.
//  Copyright © 2017年 白衣卿相. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SunShineMaskLayer : CALayer

@property (nonatomic, strong) CALayer * maskLayer;


- (instancetype)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName;
@end
