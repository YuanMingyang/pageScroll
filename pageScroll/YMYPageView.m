//
//  YMYPageView.m
//  pageScroll
//
//  Created by Yang on 2017/8/8.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "YMYPageView.h"
#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define DefTextColor [UIColor blackColor]
#define SelTextColor [UIColor redColor]

#define DefFont [UIFont systemFontOfSize:13]
#define SelFont [UIFont systemFontOfSize:15]


@interface YMYPageView()<UIScrollViewDelegate>
//顶部菜单的scrollView
@property(nonatomic,strong)UIScrollView *titleScrol;
//下边controllerscrollView
@property(nonatomic,strong)UIScrollView *vcScrol;
//所有的菜单
@property(nonatomic,strong)NSArray *titles;
//所有的vc
@property(nonatomic,strong)NSArray *viewControllers;
//顶部所有的按钮
@property(nonatomic,strong)NSMutableArray *buttons;
//当前所选的是第几个
@property(nonatomic,assign)NSInteger selIndex;
//当前是点击上方菜单还是滑动下方YES代表点击菜单
@property(nonatomic,assign)BOOL isClickTop;
@end

@implementation YMYPageView
static YMYPageView *pageView;
+(instancetype)pageViewWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles viewControllers:(NSArray<UIViewController *> *)viewControllers{
    if (!pageView) {
        pageView = [[YMYPageView alloc] initWithFrame:frame];
        pageView.titles = titles;
        pageView.viewControllers = viewControllers;
        [pageView configTitleScrollView];
        [pageView configViewControllerScrollView];
    }
    return pageView;
}
-(void)configTitleScrollView{
    self.titleScrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.titleScrol.showsHorizontalScrollIndicator = NO;
    self.titleScrol.showsVerticalScrollIndicator= NO;
    CGFloat width = 0;//顶部菜单scrollView的宽
    self.selIndex = 0;
    for (int i = 0; i<self.titles.count; i++) {
        NSDictionary *attri = @{NSFontAttributeName:SelFont};
        CGSize size = [self.titles[i] sizeWithAttributes:attri];
        width=width+size.width+10;
    }
    
    CGFloat x = 0;
    for (int i = 0; i < self.titles.count; i++) {
        //字体为17时label的宽
        NSDictionary *attri = @{NSFontAttributeName:SelFont};
        CGSize size = [self.titles[i] sizeWithAttributes:attri];
        UIButton *button = [[UIButton alloc] init];
        if (width<SCREEN_WIDTH) {
            //如果scrollView的宽小于screenWith
            button.frame = CGRectMake(x, 0, size.width+10+(SCREEN_WIDTH-width)/self.titles.count, 30);
            x=x+size.width+10+(SCREEN_WIDTH-width)/self.titles.count;
        }else{
            button.frame = CGRectMake(x, 0, size.width+10, 30);
            x=x+size.width+10;
        }
        button.tag = i;
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitle:self.titles[i] forState:UIControlStateSelected];
        [button setTitleColor:DefTextColor forState:UIControlStateNormal];
        [button setTitleColor:SelTextColor forState:UIControlStateSelected];
        
        if (i==0) {
            button.selected = YES;
            button.titleLabel.font = SelFont;
        }else{
            button.selected = NO;
            button.titleLabel.font = DefFont;
        }
        [button addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrol addSubview:button];
        
        if (!self.buttons) {
            self.buttons = [NSMutableArray array];
        }
        [self.buttons addObject:button];
    }
    if (width<SCREEN_WIDTH) {
        //如果scrollView的宽小于screenWith
        self.titleScrol.contentSize = CGSizeMake(SCREEN_WIDTH, 30);
    }else{
        self.titleScrol.contentSize = CGSizeMake(width, 30);
        
    }
    
    
    [self addSubview:self.titleScrol];
}
-(void)configViewControllerScrollView{
    self.vcScrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, self.frame.size.height-30)];
    self.vcScrol.showsHorizontalScrollIndicator = NO;
    self.vcScrol.showsVerticalScrollIndicator= NO;
    self.vcScrol.contentSize = CGSizeMake(SCREEN_WIDTH*self.viewControllers.count, self.frame.size.height-30);
    self.vcScrol.pagingEnabled = YES;
    self.vcScrol.bounces = NO;
    self.vcScrol.delegate = self;
    for (int i = 0; i<self.viewControllers.count; i++) {
        UIViewController *vc = (UIViewController *)self.viewControllers[i];
        vc.view.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, self.frame.size.height-30);
        [self.vcScrol addSubview:vc.view];
    }
    [self addSubview:self.vcScrol];
}
-(void)titleBtnClick:(UIButton *)button{
    self.isClickTop = YES;
    if (button.selected) {
        return;
    }
    self.selIndex = button.tag;
    for (UIButton *btn in self.buttons) {
        if (btn==button) {
            btn.selected = YES;
            btn.titleLabel.font = SelFont;
        }else{
            btn.selected = NO;
            btn.titleLabel.font = DefFont;
        }
    }
    [self.vcScrol setContentOffset:CGPointMake(SCREEN_WIDTH*self.selIndex, 0) animated:YES];
}

#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.isClickTop) {
        CGFloat x = scrollView.contentOffset.x;
        int page = (int)roundf(x/SCREEN_WIDTH);
        self.selIndex = page;
        for (UIButton *btn in self.buttons) {
            if (btn.tag==self.selIndex) {
                btn.selected = YES;
                btn.titleLabel.font = SelFont;
            }else{
                btn.selected = NO;
                btn.titleLabel.font = DefFont;
            }
        }
    }    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.isClickTop = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.isClickTop = NO;
}
@end
