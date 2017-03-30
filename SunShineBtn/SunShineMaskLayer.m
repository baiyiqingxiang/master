//
//  SunShineBtnLayer.m
//  SunShineBtn
//
//  Created by 白衣卿相 on 2017/3/29.
//  Copyright © 2017年 白衣卿相. All rights reserved.
//

#import "SunShineMaskLayer.h"
#import <UIKit/UIKit.h>

@implementation SunShineMaskLayer

- (instancetype)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName
{
    if (self = [super init]) {
      
        self.backgroundColor = [UIColor grayColor].CGColor;
        self.frame = frame;
        
        self.maskLayer = [CALayer layer];
        self.maskLayer.frame = self.bounds;
        self.maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:imageName].CGImage);
        self.mask = self.maskLayer;
    }
    return self;
}

@end
