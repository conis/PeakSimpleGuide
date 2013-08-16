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
  
  self.simpleGuide.frame = self.view.bounds;
  self.simpleGuide.noteBackgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
  //添加图片
  [self.simpleGuide addWithImage:[UIImage imageNamed:@"001"] note:@"第一张提示"];
  [self.simpleGuide addWithImage:[UIImage imageNamed:@"002"] note:@"另一张的提示"];
  [self.simpleGuide showInView: self.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
