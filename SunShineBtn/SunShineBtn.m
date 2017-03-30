//
//  SunShineBtn.m
//  SunShineBtn
//
//  Created by 白衣卿相 on 2017/3/29.
//  Copyright © 2017年 白衣卿相. All rights reserved.
//

#import "SunShineBtn.h"
#define RGBA(r,g,b) [UIColor colorWithRed:r/ 255.0 green:g/255.0 blue:b / 255.0 alpha:1]

@interface SunShineBtn ()<CAAnimationDelegate>

/**前景*/
@property (nonatomic, strong) CALayer * foregroundLayer;
/**圆环*/
@property (nonatomic, strong) CAShapeLayer * circleLayer;
/**颜色数组*/
@property (nonatomic, strong) NSArray * colorAry;
/**小圆点数组*/
@property (nonatomic, strong)NSMutableArray * shapeAry;
@end

@implementation SunShineBtn

- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)imageName
{
    if (self = [super initWithFrame:frame]) {
    
        self.colorAry = @[RGBA(154, 178, 66), RGBA(238, 125, 108), RGBA(236, 97, 66), RGBA(151, 111, 151)];
        self.shapeAry = [@[] mutableCopy];
        
        // 遮罩裁剪
        self.foregroundLayer = [CALayer layer];
        self.foregroundLayer.frame = CGRectMake(15, 15, self.bounds.size.width - 30, self.bounds.size.width - 30);
        self.foregroundLayer.backgroundColor = [UIColor grayColor].CGColor;
        CALayer * maskLayer = [CALayer layer];
        maskLayer.frame = CGRectMake(0, 0, self.bounds.size.width - 30, self.bounds.size.width - 30);
        maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:imageName].CGImage);
        self.foregroundLayer.mask = maskLayer;
        [self.layer addSublayer:self.foregroundLayer];
        
        // 圆环
        self.circleLayer = [CAShapeLayer layer];
        self.circleLayer.frame = self.bounds;
        self.circleLayer.fillColor = [UIColor clearColor].CGColor;
        self.circleLayer.lineWidth = 2;
        [self.layer addSublayer:self.circleLayer];
        
        // 周围的小圆点
        for (int i = 0 ; i < 10; i ++) {
            CAShapeLayer * shape  = [CAShapeLayer layer];
            [self.shapeAry addObject:shape];
        }
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)btnClick:(SunShineBtn *)sender
{
    [self scaleAnimation];
    [self diffuseCircleAnimation];
}

- (void)scaleAnimation
{
    self.foregroundLayer.backgroundColor = [self.colorAry[self.tag - 1000] CGColor];
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1;
    scaleAnimation.values = @[@0.6, @1, @0.8, @1];
    [self.foregroundLayer.mask addAnimation:scaleAnimation forKey:@"transform.scale"];
}

- (void)diffuseCircleAnimation
{
    self.circleLayer.strokeColor = [self.colorAry[self.tag - 1000] CGColor];
    CABasicAnimation * diffuseAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    diffuseAnimation.duration = 0.5;
    CGSize size = self.bounds.size;
    UIBezierPath  *fromPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/ 2, size.height / 2) radius:size.width / 4 startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    UIBezierPath  *toPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/ 2, size.height / 2) radius:size.width / 2 startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    diffuseAnimation.fromValue = (__bridge id _Nullable)(fromPath.CGPath);
    diffuseAnimation.toValue = (__bridge id _Nullable)(toPath.CGPath);
    diffuseAnimation.delegate = self;
    [self.circleLayer addAnimation:diffuseAnimation forKey:@"path"];
    
}

- (void)sunshineAnimation
{
    CALayer * backGroundLayer = [CALayer layer];
    backGroundLayer.frame = self.bounds;
    for (int i = 0; i < self.shapeAry.count; i ++) {
        
        CAShapeLayer * shape = self.shapeAry[i];
        
        // 计算各个点相对于中心点的角度（相对于 x 轴和 y 轴的角度）
        CGFloat angle = M_PI * 2 / self.shapeAry.count * i;
        // 圆环半径
        CGFloat  banjing  = self.bounds.size.width / 2;
        // 各个点相对于中心点的偏移量 根据正余弦函数计算
        CGFloat shapeX = banjing * cos(angle);
        CGFloat shapeY = banjing * sin(angle);
        // 设置圆环的大小
        CGFloat shapeW = i % 2 == 0 ? 10.f : 6.f;
        CGFloat shapeH = i % 2 == 0 ? 10.f : 6.f;
    
        // 设置 frame
        shape.frame = CGRectMake(shapeX + banjing - shapeW / 2, shapeY + banjing - shapeH / 2, shapeW, shapeH);
        // 设置填充色
        shape.fillColor = [UIColor colorWithRed:(arc4random() % 255)/ 255.0 green:(arc4random() % 255)/ 255.0 blue:(arc4random() % 255)/ 255.0 alpha:1].CGColor;
        
        [backGroundLayer addSublayer:shape];
        
        // 点变小
        CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        basicAnimation.duration = 0.5;
        basicAnimation.fromValue = (__bridge id _Nullable)[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, shapeW, shapeH)].CGPath;
        basicAnimation.toValue = (__bridge id _Nullable)[UIBezierPath bezierPathWithOvalInRect:CGRectMake(shapeW / 2, shapeH / 2, 0, 0)].CGPath;
        [shape addAnimation:basicAnimation forKey:@"path"];

        // 旋转
        CABasicAnimation * rote = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rote.duration = 0.5;
        rote.fromValue = [NSNumber numberWithFloat:0];
        rote.toValue = [NSNumber numberWithFloat:1];
        [backGroundLayer addAnimation:rote forKey:@"transform.rotation.z"];
        
        // 放大
        CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = 0.5;
        scaleAnimation.values = @[@0.8, @1.4];
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        [backGroundLayer addAnimation:scaleAnimation forKey:@"transform.scale"];
    }
    [self.layer addSublayer:backGroundLayer];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
     [self sunshineAnimation];
}


@end
