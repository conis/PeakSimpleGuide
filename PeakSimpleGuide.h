//
//  PeakSimpleGuide.h
//
//  Created by conis on 8/16/13.
//  Copyright (c) 2013 conis. All rights reserved.
//  Blog: http://iove.net
//  E-mail: conis.yi@gmail.com
//  一个简单的Guide模块，可以轮播显示图片及图片描述，到最后一页会自动隐藏.

#import <UIKit/UIKit.h>

//委托
@protocol PeakSimpleGuideDelegate <NSObject>
-(void) peakSimpleGuideDidFinish;
@end
@interface PeakSimpleGuide : UIView<UIScrollViewDelegate>

//是否显示过guide，不管哪一个版本
@property (nonatomic, readonly) BOOL guideShown;
//当前版本的guide是否已经显示
@property (nonatomic, readonly) BOOL guideShownAtCurrentVersion;
//委托
@property (nonatomic, weak) id<PeakSimpleGuideDelegate> delegate;
//介绍信息的高度
@property (nonatomic) CGFloat noteHeight;
//介绍信息的背景色
@property (nonatomic, strong) UIColor *noteBackgroundColor;
//介绍的字体
@property (nonatomic, strong) UIFont *noteFont;
//介绍的文字颜色
@property (nonatomic, strong) UIColor *noteTextColor;
//在哪个View中显示
-(void) showInView: (UIView *) parent;
//添加一组图
-(void) addGuideWithImage: (UIImage *) image note: (NSString *) note;
//批量添加guide
-(void) bulkAddGuide: (NSInteger) count imageName: (NSString *) imageName noteName: (NSString *) noteName;
@end
