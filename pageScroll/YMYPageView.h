//
//  YMYPageView.h
//  pageScroll
//
//  Created by Yang on 2017/8/8.
//  Copyright © 2017年 A589. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMYPageView : UIView
+(instancetype)pageViewWithFrame:(CGRect)frame titles:(NSArray<NSString *>*)titles viewControllers:(NSArray<UIViewController *>*)viewControllers;
@end
