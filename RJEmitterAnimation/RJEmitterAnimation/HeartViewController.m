//
//  HeartViewController.m
//  RJEmitterAnimation
//
//  Created by Ru on 2020/7/13.
//  Copyright © 2020 JianBin. All rights reserved.
//

#import "HeartViewController.h"

@interface HeartViewController ()

@property (nonatomic, strong) CAEmitterLayer * heartLayer;


@end

@implementation HeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupEmitter];
    
}

- (void)setupEmitter{
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.text = @"轻点屏幕以产生爱心";
    label.textAlignment = NSTextAlignmentCenter;
    
    // 1.CAEmitterLayer
    CAEmitterLayer * heartLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:heartLayer];
    self.heartLayer = heartLayer;
    
    heartLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height - 20);
    heartLayer.emitterShape = kCAEmitterLayerRectangle;
    heartLayer.emitterMode = kCAEmitterLayerVolume;
    heartLayer.renderMode = kCAEmitterLayerAdditive;
    heartLayer.emitterSize = CGSizeMake(100, 30);
//    heartLayer.emitterSize = self.view.frame.size;
    
    // 2.配置CAEmitterCell
    CAEmitterCell * heartCell = [CAEmitterCell emitterCell];
    heartCell.name = @"heartCell";
    
    heartCell.birthRate = 0.f;
    heartCell.lifetime = 10.f;
    
    heartCell.velocity = -120.f;
    heartCell.velocityRange = 60.f;
    heartCell.yAcceleration = 20.f;
    
    heartCell.emissionLongitude = M_PI * 0.5;
    heartCell.emissionRange = M_PI_2 * 0.55;
    
    heartCell.contents = (id)[[UIImage imageNamed:@"love_red"]CGImage];
    heartCell.color = [[UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.5] CGColor];
    heartCell.redRange = 0.3;
    heartCell.blueRange = 0.3;
    heartCell.alphaRange = -0.5/heartCell.lifetime;  // 这句代码没懂什么意思
    
    heartCell.scale = 0.5;
    heartCell.scaleRange = 0.5;
    heartCell.spinRange = 2.0 * M_PI;  // 自转
    
    // 添加动画
    heartLayer.emitterCells = @[heartCell];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 添加动画
    CABasicAnimation * heartAnim = [CABasicAnimation animationWithKeyPath:@"emitterCells.heartCell.birthRate"];
    heartAnim.fromValue = @150.f;
    heartAnim.toValue = @0.f;
    heartAnim.duration = 5.f;
    heartAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.heartLayer addAnimation:heartAnim forKey:@"heartAnim"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
