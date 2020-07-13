//
//  RainViewController.m
//  RJEmitterAnimation
//
//  Created by Ru on 2020/7/13.
//  Copyright © 2020 JianBin. All rights reserved.
//

#import "RainViewController.h"

@interface RainViewController ()
@property (nonatomic, strong) CAEmitterLayer  *rainLayer;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation RainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupEmitter];
}

- (void)setupUI{
    
    // 背景图片
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    imageView.image = [UIImage imageNamed:@"tree.jpg"];
    
    // 下雨按钮
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startBtn];
    startBtn.frame = CGRectMake(20, self.view.bounds.size.height - 100, 80, 40);
    startBtn.backgroundColor = [UIColor whiteColor];
    [startBtn setTitle:@"雨停了" forState:UIControlStateNormal];
    [startBtn setTitle:@"下雨" forState:UIControlStateSelected];
    [startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 雨量按钮
    UIButton * rainBIgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rainBIgBtn];
    rainBIgBtn.tag = 100;
    rainBIgBtn.frame = CGRectMake(140, self.view.bounds.size.height - 100, 80, 40);
    rainBIgBtn.backgroundColor = [UIColor whiteColor];
    [rainBIgBtn setTitle:@"下大点" forState:UIControlStateNormal];
    [rainBIgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rainBIgBtn addTarget:self action:@selector(rainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rainSmallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rainSmallBtn];
    rainSmallBtn.tag = 200;
    rainSmallBtn.frame = CGRectMake(240, self.view.bounds.size.height - 100, 80, 40);
    rainSmallBtn.backgroundColor = [UIColor whiteColor];
    [rainSmallBtn setTitle:@"太大了" forState:UIControlStateNormal];
    [rainSmallBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rainSmallBtn addTarget:self action:@selector(rainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)buttonClick:(UIButton *)sender{
    
    if (!sender.selected) {
        
        sender.selected = !sender.selected;
        NSLog(@"雨停了");
        
        // 停止下雨
        [self.rainLayer setValue:@0.f forKeyPath:@"birthRate"];
        
    }else{
        
        sender.selected = !sender.selected;
        NSLog(@"开始下雨了");
        
        // 开始下雨
        [self.rainLayer setValue:@1.f forKeyPath:@"birthRate"];
    }
}

- (void)rainButtonClick:(UIButton *)sender{
    
    NSInteger rate = 1;
    CGFloat scale = 0.05;
    if (sender.tag == 100) {
        
        NSLog(@"下大了");
        
        if (self.rainLayer.birthRate < 30) {
            [self.rainLayer setValue:@(self.rainLayer.birthRate + rate) forKeyPath:@"birthRate"];
            [self.rainLayer setValue:@(self.rainLayer.scale + scale) forKeyPath:@"scale"];
        }
        
    }else if (sender.tag == 200){
        
        NSLog(@"变小了");
        
        if (self.rainLayer.birthRate > 1) {
            [self.rainLayer setValue:@(self.rainLayer.birthRate - rate) forKeyPath:@"birthRate"];
            [self.rainLayer setValue:@(self.rainLayer.scale - scale) forKeyPath:@"scale"];
        }
    }
}

- (void)setupEmitter {
    CAEmitterLayer *rainLayer = [CAEmitterLayer layer];
    [self.imageView.layer addSublayer:rainLayer];
    self.rainLayer = rainLayer;
    
    rainLayer.emitterShape = kCAEmitterLayerLine;
    rainLayer.emitterMode = kCAEmitterLayerSurface;
    rainLayer.emitterSize = self.view.bounds.size;
    rainLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, -10);
    //设置cell
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    snowCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"rain_white"].CGImage);
    snowCell.birthRate = 20;
    snowCell.lifetime = 10;
    snowCell.speed = 1;
    
    snowCell.velocity = 10;
    snowCell.velocityRange = 10;
    snowCell.yAcceleration = 1000;
    
    snowCell.scale = 0.1;
    snowCell.scaleRange = 0;
    rainLayer.emitterCells = @[snowCell];
    
}

@end
