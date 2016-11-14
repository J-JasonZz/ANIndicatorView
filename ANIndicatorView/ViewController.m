//
//  ViewController.m
//  ANIndicatorView
//
//  Created by JasonZhang on 2016/11/11.
//  Copyright © 2016年 wscn. All rights reserved.
//

#import "ViewController.h"
#import "ANIndicatorView.h"

@interface ViewController ()

@property (nonatomic, strong) ANIndicatorView *indicatorView;

@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@property (weak, nonatomic) IBOutlet UISlider *ballCountSlider;

@property (weak, nonatomic) IBOutlet UISlider *ballSpeedSlider;

@property (weak, nonatomic) IBOutlet UISlider *ballRadiusSlider;

@property (weak, nonatomic) IBOutlet UISlider *indicatorViewRadiusSlider;

@property (weak, nonatomic) IBOutlet UILabel *ballCountValue;

@property (weak, nonatomic) IBOutlet UILabel *ballSpeedValue;

@property (weak, nonatomic) IBOutlet UILabel *ballRadiusValue;

@property (weak, nonatomic) IBOutlet UILabel *indicatorViewRadiusValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup
{
    self.indicatorView = [ANIndicatorView createIndicatorViewWithFrame:CGRectMake((self.view.frame.size.width - 200.f) / 2.f, (CGRectGetMinY(self.restartButton.frame) - 200.f) / 2.f, 200.f, 200.f)
                                                             BallCount:[self.ballCountValue.text integerValue]
                                                             ballColor:[UIColor orangeColor]
                                                             ballspeed:[self.ballSpeedValue.text floatValue]
                                                            ballRadius:[self.ballRadiusValue.text floatValue]
                                                    indicatorViewRaius:[self.indicatorViewRadiusValue.text floatValue]];
//    self.indicatorView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.indicatorView];
}

#pragma mark -- Event
- (IBAction)restartButtonClick:(id)sender {
    [self.indicatorView removeFromSuperview];
    [self setup];
    [self.indicatorView startAnimation];
}

- (IBAction)indicatorSliderValueChanged:(id)sender {
    if (sender == self.ballCountSlider) {
        self.ballCountSlider.value = round(self.ballCountSlider.value);
        self.ballCountValue.text = [NSString stringWithFormat:@"%ld", (NSInteger)self.ballCountSlider.value];
    } else if (sender == self.ballSpeedSlider) {
        self.ballSpeedValue.text = [NSString stringWithFormat:@"%.2f", self.ballSpeedSlider.value];
    } else if (sender == self.ballRadiusSlider) {
        self.ballRadiusValue.text = [NSString stringWithFormat:@"%.2f", self.ballRadiusSlider.value];
    } else if (sender == self.indicatorViewRadiusSlider) {
        self.indicatorViewRadiusValue.text = [NSString stringWithFormat:@"%.2f", self.indicatorViewRadiusSlider.value];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
