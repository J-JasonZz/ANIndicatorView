//
//  ANIndicatorView.h
//  ANIndicatorView
//
//  Created by JasonZhang on 2016/11/11.
//  Copyright © 2016年 wscn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANIndicatorView : UIView

/**
 小球的个数
 */
@property (nonatomic, assign, readonly) NSInteger indicatorBallCount;

/**
 小球的颜色
 */
@property (nonatomic, strong, readonly) UIColor *indicatorBallColor;

/**
 小球的速度
 */
@property (nonatomic, assign, readonly) CGFloat indicatorBallSpeed;

/**
 小球的半径
 */
@property (nonatomic, assign, readonly) CGFloat indicatorBallRadius;

/**
 指示器的半径
 */
@property (nonatomic, assign, readonly) CGFloat indicatorViewRadius;

/**
 是否正在动画
 */
@property (nonatomic, assign, readonly) BOOL isAnimation;

+ (instancetype)createIndicatorViewWithFrame:(CGRect)frame
                                   BallCount:(NSInteger)ballCount
                                       ballColor:(UIColor *)ballColor
                                       ballspeed:(CGFloat)ballSpeed
                                      ballRadius:(CGFloat)ballRadius
                              indicatorViewRaius:(CGFloat)indicatorViewRaius;

- (void)startAnimation;
- (void)stopAnimation;
@end
