//
//  ViewController.m
//  pageScroll
//
//  Created by Yang on 2017/8/8.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "ViewController.h"
#import "YMYPageView.h"
#import "ListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *arr = [NSMutableArray array];
    ListViewController *vc0 = [[ListViewController alloc] init];
    vc0.color = @"红色";
    
    ListViewController *vc1 = [[ListViewController alloc] init];
    vc1.color = @"黄色";
    
    ListViewController *vc2 = [[ListViewController alloc] init];
    vc2.color = @"橘黄色";
    
    ListViewController *vc7 = [[ListViewController alloc] init];
    vc7.color = @"神器的颜色";
    
    
    ListViewController *vc3 = [[ListViewController alloc] init];
    vc3.color = @"蓝色";
    
    ListViewController *vc4 = [[ListViewController alloc] init];
    vc4.color = @"绿色";
    
    ListViewController *vc5 = [[ListViewController alloc] init];
    vc5.color = @"黑色";
    
    [arr addObject:vc0];
    [arr addObject:vc1];
    [arr addObject:vc2];
    [arr addObject:vc7];
    [arr addObject:vc3];
    [arr addObject:vc4];
    [arr addObject:vc5];
    YMYPageView *page = [YMYPageView pageViewWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) titles:@[@"红色红色",@"黄色黄色",@"橘黄色橘黄色",@"神器的颜色",@"蓝色蓝色",@"绿色绿色",@"黑色黑色"] viewControllers:arr];
    [self.view addSubview:page];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
