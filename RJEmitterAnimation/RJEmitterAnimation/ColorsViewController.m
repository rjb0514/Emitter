//
//  ColorsViewController.m
//  RJEmitterAnimation
//
//  Created by Ru on 2020/7/13.
//  Copyright © 2020 JianBin. All rights reserved.
//

#import "ColorsViewController.h"

@interface ColorsViewController ()

@property (nonatomic, strong) CAEmitterLayer * colorBallLayer;


@end

@implementation ColorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupEmitter];
}

- (void)setupEmitter{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
       [self.view addSubview:label];
       label.textColor = [UIColor whiteColor];
       label.text = @"轻点或拖动来改变发射源位置";
       label.textAlignment = NSTextAlignmentCenter;
    
    // 1. 设置CAEmitterLayer
      CAEmitterLayer * colorBallLayer = [CAEmitterLayer layer];
      [self.view.layer addSublayer:colorBallLayer];
      self.colorBallLayer = colorBallLayer;
      
      colorBallLayer.emitterSize = self.view.frame.size;
      colorBallLayer.emitterShape = kCAEmitterLayerPoint;
      colorBallLayer.emitterMode = kCAEmitterLayerPoints;
      colorBallLayer.emitterPosition = CGPointMake(self.view.layer.bounds.size.width, 0.f);
    
    CAEmitterCell *colorCell = [CAEmitterCell emitterCell];
    colorCell.name = @"colorCell";
    colorCell.birthRate = 20;
    colorCell.lifetime = 10;
    
    colorCell.velocity = 40;
    colorCell.velocityRange = 100;
    colorCell.yAcceleration = 13;
    
    colorCell.emissionLongitude = M_PI;//向左
    colorCell.emissionRange = M_PI_4; // 围绕x轴向左90度
    
    colorCell.scale = 0.2;
    colorCell.scaleRange = 0.1;
    colorCell.scaleSpeed = 0.02;
    
    colorCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"circle_white"].CGImage);
    colorCell.color = [UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:1.0].CGColor;
    colorCell.redRange = 1;
    colorCell.blueRange =1;
    colorCell.greenRange = 1;
    colorCell.alphaRange = 0.8;
    colorCell.alphaSpeed = -0.1f;
    
    colorBallLayer.emitterCells = @[colorCell];
        
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint temp = [touch locationInView:self.view];
    [self setBAllInpositon:temp];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
      CGPoint temp = [touch locationInView:self.view];
    [self setBAllInpositon:temp];
}

//移动发射源到某个点上
- (void)setBAllInpositon:(CGPoint)positon {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"emitterCells.colorCell.scale"];
    anim.fromValue = @0.2;
    anim.toValue = @0.5;
    anim.duration = 1.0;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
    [self.colorBallLayer addAnimation:anim forKey:nil];
    [self.colorBallLayer setValue:[NSValue valueWithCGPoint:positon] forKey:@"emitterPosition"];
//    [CATransaction commit];
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
