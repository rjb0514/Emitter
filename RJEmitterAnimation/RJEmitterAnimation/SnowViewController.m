//
//  SnowViewController.m
//  RJEmitterAnimation
//
//  Created by Ru on 2020/7/13.
//  Copyright © 2020 JianBin. All rights reserved.
//

#import "SnowViewController.h"

@interface SnowViewController ()
@property (nonatomic, strong) CAEmitterLayer * snowLayer;

@end

@implementation SnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupEmitter];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.center = CGPointMake(200, 200);
}

- (void)btnClick {
    [self.snowLayer setValue:@20 forKey:@"birthRate"];
    
    [self performSelector:@selector(stop) withObject:nil afterDelay:2];
}

- (void)stop {
    [self.snowLayer setValue:@0 forKey:@"birthRate"];
}

- (void)setupEmitter{
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"tree.jpg"];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    CAEmitterLayer *snowLayer = [CAEmitterLayer layer];
    [imageView.layer addSublayer:snowLayer];
    self.snowLayer = snowLayer;
    
    snowLayer.emitterShape = kCAEmitterLayerLine;
    snowLayer.emitterMode = kCAEmitterLayerSurface;
    snowLayer.emitterSize = self.view.bounds.size;
    snowLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, -10);
    
    // 2. 配置cell
       CAEmitterCell * snowCell = [CAEmitterCell emitterCell];
       snowCell.contents = (id)[[UIImage imageNamed:@"snow_white"] CGImage];
       
       snowCell.birthRate = 1.f;
       snowCell.lifetime = 200.f;
       snowCell.speed = 10.f;
       
       snowCell.velocity = 2.f;
       snowCell.velocityRange = 10.f;
       snowCell.yAcceleration = 10.f;
       
       snowCell.scale = 0.2;
       snowCell.scaleRange = 0.3f;
       
       snowCell.emissionLongitude = M_PI_2; // 向下
       snowCell.emissionRange = M_PI_4; // 向下
       
       // 3.添加到图层上
       snowLayer.emitterCells = @[snowCell];
    
    
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
