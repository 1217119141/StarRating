//
//  ViewController.m
//  xingxing
//
//  Created by iOS开发 on 16/12/12.
//  Copyright © 2016年 iOS开发. All rights reserved.
//

#import "ViewController.h"
#import "LTStarView.h"
@interface ViewController ()<LTStarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LTStarView * starView = [[LTStarView alloc]initWithFrame:CGRectMake(100, 100, 104, 20) numberOfStars:5 isVariable:YES];
    starView.starType = StatType_TheWholeStar;//整颗星
    starView.delegate = self;
    [self.view addSubview:starView];
}
//#pragma mark - LTStarViewDelegate
//- (void)starView:(LTStarView *)view score:(CGFloat)score
//{
//    NSLog(@"分数  %.2f",score);
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
