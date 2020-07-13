//
//  ViewController.m
//  RJEmitterAnimation
//
//  Created by Ru on 2020/7/13.
//  Copyright © 2020 JianBin. All rights reserved.
//

#import "ViewController.h"
#import "RainViewController.h"
#import "SnowViewController.h"
#import "ColorsViewController.h"
#import "HeartViewController.h"
#import "FireViewController.h"
#import "FireworksViewController.h"
#import "LikeViewController.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = @[@"下雨",@"下雪",@"小球",@"爱心",@"火焰",@"烟花",@"点赞"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        //下雨
        RainViewController *vc = [RainViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        SnowViewController *vc = [SnowViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2) {
        ColorsViewController *vc = [ColorsViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3) {
        HeartViewController *vc = [HeartViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4) {
        FireViewController *vc = [FireViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5) {
        FireworksViewController *vc = [FireworksViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 6) {
        LikeViewController *vc = [LikeViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}


@end
