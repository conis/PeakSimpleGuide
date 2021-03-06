//
//  PeakSimpleGuide.m
//
//  Created by conis on 8/16/13.
//  Copyright (c) 2013 conis. All rights reserved.
//

#import "PeakSimpleGuide.h"
@interface PeakSimpleGuide()
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic) NSInteger lastPageIndex;
@end

@implementation PeakSimpleGuide
static NSString *kGuideVersion = @"peakSimpleGuide_version";

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setDefaults];
  }
  return self;
}

- (id) init{
  self = [super init];
  if (self) {
    [self setDefaults];
  }
  return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self setDefaults];
  }
  return self;
}

-(void) setDefaults{
  self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
  self.noteHeight = 60;
  self.noteFont = [UIFont systemFontOfSize: 20];
  self.noteBackgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
  self.noteTextColor = [UIColor whiteColor];
  
  self.scrollView = [[UIScrollView alloc] initWithFrame: self.bounds];
  self.scrollView.pagingEnabled = YES;
  self.scrollView.delegate = self;
  self.scrollView.showsHorizontalScrollIndicator = NO;
  self.scrollView.showsVerticalScrollIndicator = NO;
  self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  self.scrollView.alwaysBounceVertical = NO;
  [self addSubview: self.scrollView];
  
  self.pageControl = [[UIPageControl alloc] init];
  self.pageControl.frame = CGRectMake(0, self.bounds.size.height - self.noteHeight - 36 / 2, self.frame.size.width, 36);
  self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
  [self addSubview: self.pageControl];
}

//添加一个guide
-(void) addGuideWithImage:(UIImage *)image note:(NSString *)note{
  CGFloat left = self.pageControl.numberOfPages * self.frame.size.width;
  CGFloat width = self.bounds.size.width;
  CGFloat height = self.bounds.size.height;
  
  UIImageView *imgView = [[UIImageView alloc] initWithImage: image];
  imgView.contentMode = UIViewContentModeTopLeft;
  imgView.frame = CGRectMake(left, 0, width, height);
  imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [self.scrollView addSubview: imgView];
  
  //添加memo
  UILabel *lblNote = [[UILabel alloc] init];
  lblNote.text = note;
  lblNote.font = self.noteFont;
  lblNote.backgroundColor = self.noteBackgroundColor;
  lblNote.textAlignment = NSTextAlignmentCenter;
  lblNote.frame = CGRectMake(left, height - self.noteHeight, width, self.noteHeight);
  lblNote.textColor = self.noteTextColor;
  lblNote.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
  lblNote.numberOfLines = 0;
  [self.scrollView addSubview: lblNote];
  
  //重新设置scrollView
  self.pageControl.numberOfPages ++;
  self.scrollView.contentSize = CGSizeMake(width * self.pageControl.numberOfPages, 0);
}

//批量添加guide
-(void) bulkAddGuide:(NSInteger)count imageName:(NSString *)imageName noteName:(NSString *)noteName{
    for (int i = 0; i < count; i ++) {
      NSString *note = [NSString stringWithFormat:noteName, i];
      note = NSLocalizedString(note, nil);
      [self addGuideWithImage:[UIImage imageNamed: [NSString stringWithFormat: imageName, i]] note: note];
    };
}

//滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  NSInteger pageIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
  
  //完成
  NSInteger last = self.pageControl.numberOfPages - 1;
  if (pageIndex == last && self.lastPageIndex == last) {
    [UIView animateWithDuration:0.3 animations:^{
      self.alpha = 0;
    } completion:^(BOOL finished) {
      //保存已经显示过guide的信息
      [self save];
      //通知完成
      if(self.delegate && [self.delegate respondsToSelector: @selector(peakSimpleGuideDidFinish)]){
        [self.delegate peakSimpleGuideDidFinish];
      }
    }];
    return;
  };
  
  self.lastPageIndex = pageIndex;
  self.pageControl.currentPage = pageIndex;
}

-(void) layoutSubviews{
  [super layoutSubviews];
  //self.pageControl.frame = CGRectMake(0, self.bounds.size.height - self.noteHeight - 36 / 2, self.frame.size.width, 36);
  //self.scrollView.frame = self.bounds;
}

//在父视图中显示
-(void) showInView:(UIView *)parent{
  self.frame = parent.bounds;
  [parent addSubview: self];
}

//获取当前版本
-(NSString *) currentVersion{
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];;
}

//保存显示guide的版本信息
-(void) save{
  NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:[self currentVersion] forKey:kGuideVersion];
  [defaults synchronize];
}


-(NSString *) getGuideShownVersion{
  NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
  return [defaults stringForKey: kGuideVersion];
}

//guide是否已经显示过了，不管是不是当前版本
-(BOOL) guideShown{
  NSString *shownVersion = [self getGuideShownVersion];
  return shownVersion != nil;
}

//当前版本是否已经显示过guide
-(BOOL) guideShownAtCurrentVersion{
  NSString *shownVersion = [self getGuideShownVersion];
  NSString *currentVersion = [self currentVersion];
  return [shownVersion isEqualToString: currentVersion];
}
@end
