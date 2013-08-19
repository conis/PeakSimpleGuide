//
//  ViewController.m
//  PeakSimpleGuide-Samples
//
//  Created by conis on 8/16/13.
//  Copyright (c) 2013 conis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  if(self.simpleGuide.guideShown){
    NSLog(@"已经显示过Guide，但不一定是当前版本");
  }

  if(self.simpleGuide.guideShown){
    NSLog(@"当前版本已经显示过Guide");
  }
  
  self.simpleGuide.frame = self.view.bounds;
  self.simpleGuide.noteBackgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
  //添加图片
  [self.simpleGuide addGuideWithImage:[UIImage imageNamed:@"001"] note:@"第一张提示"];
  [self.simpleGuide addGuideWithImage:[UIImage imageNamed:@"002"] note:@"另一张的提示"];
  [self.simpleGuide showInView: self.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
