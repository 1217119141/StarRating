//
//  LTStarView.m
//  xingxing
//
//  Created by iOS开发 on 16/12/12.
//  Copyright © 2016年 iOS开发. All rights reserved.
//

#import "LTStarView.h"

@interface LTStarView()
{
    CGFloat eachWidth;
}
//星星之间的左右间隔
@property (nonatomic,assign)CGFloat widDistance;
//星星之间的上下间隔
@property (nonatomic,assign)CGFloat heiDistance;
//灰色星星
@property (nonatomic,strong)UIView * grayStarView;
//表示分数星星
@property (nonatomic,strong)UIView * foreStarView;
//最低分数
@property (nonatomic,assign)CGFloat lowestScore;
//星星颗数
@property (nonatomic, assign) NSInteger numberOfStars;
@end
@implementation LTStarView

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars isVariable:(BOOL)isVariable
{
    self = [super initWithFrame:frame];
    self.numberOfStars = numberOfStars;
    if (self) {
        _starType = StatType_TheWholeStar;
        self.widDistance = 1;
        self.heiDistance = 0;
        self.lowestScore = 1;
        
        self.grayStarView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.grayStarView];
        self.foreStarView = [[UIView alloc]initWithFrame:self.bounds];
        self.foreStarView.clipsToBounds = YES;
        [self addSubview:self.foreStarView];
        
        eachWidth = (CGRectGetWidth(self.frame)-(self.numberOfStars-1)*self.widDistance)/self.numberOfStars;
        CGFloat height = CGRectGetHeight(self.frame)-2*self.heiDistance;
        for (int i = 0; i < self.numberOfStars; i++) {
            UIImage * grayImg = [UIImage imageNamed:@"xingxing"];
            UIImageView * grayImgView = [[UIImageView alloc]initWithFrame:CGRectMake((eachWidth+self.widDistance)*i, self.heiDistance, eachWidth, height)];
            grayImgView.image = grayImg;
            [self.grayStarView addSubview:grayImgView];
            
            UIImage * foreImg = [UIImage imageNamed:@"xingxing_y"];
            UIImageView * foreImgView = [[UIImageView alloc]initWithFrame:CGRectMake((eachWidth+self.widDistance)*i, self.heiDistance, eachWidth, height)];
            foreImgView.image = foreImg;
            [self.foreStarView addSubview:foreImgView];
        }
        if (isVariable) {
            UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureEvent:)];
            UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureEvent:)];
            [self addGestureRecognizer:tapGesture];
            [self addGestureRecognizer:panGesture];
        }
        self.score = self.lowestScore;
    }
    
    return self;
}
#pragma mark - 设置当前分数
- (void)setScore:(CGFloat)score
{
    _score = score;
    
    if (_starType == StatType_TheWholeStar) {
        _score = (int)score;
    }
    
    CGPoint point = CGPointMake((eachWidth+self.widDistance)*_score, self.heiDistance);
    [self changeStarForeViewWithPoint:point];
}

#pragma mark - 设置当前类型
- (void)setRatingType:(StatType)starType
{
    _starType = starType;
    
    [self setScore:_score];
}
#pragma mark - 点击
- (void)tapGestureEvent:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
    
    if(_starType == StatType_TheWholeStar){
        NSInteger count = (NSInteger)(point.x/(eachWidth+self.widDistance))+1;
        point.x = count*(eachWidth+self.widDistance);
    }
    
    [self changeStarForeViewWithPoint:point];
}


#pragma mark - 滑动
- (void)panGestureEvent:(UIPanGestureRecognizer *)pan
{
    
    CGPoint point = [pan locationInView:self];
    
    if (point.x < 0) {
        return;
    }
    if(_starType == StatType_TheWholeStar){
        NSInteger count = (NSInteger)(point.x/(eachWidth+self.widDistance))+1;
        point.x = count*(eachWidth+self.widDistance);
    }
    
    [self changeStarForeViewWithPoint:point];
}
#pragma mark - 设置显示的星星
- (void)changeStarForeViewWithPoint:(CGPoint)point
{
    if (point.x < 0) {
        return;
    }
    
    if (point.x < self.lowestScore)
    {
        point.x = self.lowestScore;
    }
    else if (point.x > self.frame.size.width)
    {
        point.x = self.frame.size.width;
    }
    
    float score = point.x/CGRectGetWidth(self.frame);
    CGRect frameRect = self.foreStarView.frame;
    frameRect.size.width = point.x;
    self.foreStarView.frame = frameRect;
    
    _score = score * self.numberOfStars;
    
    if(_starType == StatType_TheWholeStar){
        _score = (int)_score;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starView:score:)])
    {
        [self.delegate starView:self score:self.score];
    }
}
@end
