//
//  BtnBackgroundView.m
//  SunShineBtn
//
//  Created by 白衣卿相 on 2017/3/29.
//  Copyright © 2017年 白衣卿相. All rights reserved.
//

#import "BtnBackgroundView.h"
#import "SunShineBtn.h"

@interface BtnBackgroundView ()


@end

@implementation BtnBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    NSArray * imageAry = @[@"heart",@"like",@"smile",@"star"];
    CGFloat width = self.bounds.size.width;
    CGFloat margin = (width - 70 * 4 - 50) / 3;
    for (int i = 0; i  < 4; i ++) {
        SunShineBtn * button = [[SunShineBtn alloc] initWithFrame:CGRectMake((70 + margin) * i + 30, 20, 70 ,70) andImage:imageAry[i]];;
        button.tag  = 1000 + i;
        [self addSubview:button];
    }
}





@end
