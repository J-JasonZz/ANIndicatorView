//
//  ANIndicatorView.m
//  ANIndicatorView
//
//  Created by JasonZhang on 2016/11/11.
//  Copyright © 2016年 wscn. All rights reserved.
//

#import "ANIndicatorView.h"

@interface ANIndicatorView ()

@property (nonatomic, assign) NSInteger indicatorBallCount;

@property (nonatomic, strong) UIColor *indicatorBallColor;

@property (nonatomic, assign) CGFloat indicatorBallSpeed;

@property (nonatomic, assign) CGFloat indicatorBallRadius;

@property (nonatomic, assign) CGFloat indicatorViewRadius;

@property (nonatomic, strong) NSArray *indicatorBalls;

@property (nonatomic, assign) BOOL isAnimation;

@end

@implementation ANIndicatorView

+ (instancetype)createIndicatorViewWithFrame:(CGRect)frame
                                   BallCount:(NSInteger)ballCount
                                   ballColor:(UIColor *)ballColor
                                   ballspeed:(CGFloat)ballSpeed
                                  ballRadius:(CGFloat)ballRadius
                          indicatorViewRaius:(CGFloat)indicatorViewRaius
{
    ANIndicatorView *indicatorView = [[ANIndicatorView alloc] initWithFrame:frame];
    indicatorView.indicatorBallCount = ballCount;
    indicatorView.indicatorBallColor = ballColor;
    indicatorView.indicatorBallSpeed = ballSpeed;
    indicatorView.indicatorBallRadius = ballRadius;
    indicatorView.indicatorViewRadius = indicatorViewRaius;
    indicatorView.isAnimation = NO;
    [indicatorView setup];
    return indicatorView;
}

- (void)setup
{
    NSMutableArray *indicatorBalls = [NSMutableArray array];
    for (NSInteger index = 0; index < self.indicatorBallCount; index++) {
        UIView *indicatorBall = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - self.indicatorBallRadius*2.f) / 2.f, 0, self.indicatorBallRadius*2.f, self.indicatorBallRadius*2.f)];
        indicatorBall.layer.cornerRadius = self.indicatorBallRadius;
        indicatorBall.layer.masksToBounds = YES;
        indicatorBall.backgroundColor = self.indicatorBallColor;
        [self addSubview:indicatorBall];
        [indicatorBalls addObject:indicatorBall];
    }
    self.indicatorBalls = [NSArray arrayWithArray:indicatorBalls];
}

- (void)startAnimation
{
    self.isAnimation = YES;

    for (NSInteger index = 0; index < self.indicatorBalls.count; index++) {
        UIView *indicatorBall = self.indicatorBalls[index];
        [indicatorBall.layer addAnimation:[self positionAnimationWithIndex:index] forKey:@"PositionAnimation"];
        [indicatorBall.layer addAnimation:[self scaleAnimationWithIndex:index] forKey:@"ScaleAnimation"];
    }
}

- (CAKeyframeAnimation *)positionAnimationWithIndex:(NSInteger)index
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 100.f / self.indicatorBallSpeed;
    animation.repeatCount = CGFLOAT_MAX;
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :0.1+index*(1.0/self.indicatorBalls.count) :0.25 :1];
    animation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2.f, self.bounds.size.height / 2.f) radius:(self.indicatorViewRadius - self.indicatorBallRadius) startAngle:3 * M_PI / 2 endAngle:3 * M_PI / 2 + 2 * M_PI clockwise:YES].CGPath;
    return animation;
}

- (CABasicAnimation *)scaleAnimationWithIndex:(NSInteger)index
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 100.f / self.indicatorBallSpeed;
    animation.repeatCount = CGFLOAT_MAX;
    animation.fromValue = @(1 - index*(1.0/self.indicatorBalls.count));
    animation.toValue = @(0.2 + index*(1.0/self.indicatorBalls.count));
    if (1 - index*(1.0/self.indicatorBalls.count) > 0.2 + index*(1.0/self.indicatorBalls.count)) {
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    } else {
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }
    return animation;
}

- (void)stopAnimation
{
    self.isAnimation = NO;
    for (UIView *indicatorBall in self.indicatorBalls) {
        [indicatorBall.layer removeAllAnimations];
    }
}

@end
