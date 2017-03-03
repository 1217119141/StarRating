//
//  LTStarView.h
//  xingxing
//
//  Created by iOS开发 on 16/12/12.
//  Copyright © 2016年 iOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, StatType){
    StatType_HalfStars = 0,           //半颗星
    StatType_TheWholeStar         //整颗星
};
@class LTStarView;

@protocol LTStarViewDelegate <NSObject>

@optional

- (void)starView:(LTStarView *)view score:(CGFloat)score;

@end

@interface LTStarView : UIView
//评分类型，整颗星或半颗星
@property (nonatomic,assign)StatType starType;
//当前分数
@property (nonatomic,assign)CGFloat score;
//是否可以点击 默认为YES
@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,assign)id<LTStarViewDelegate> delegate;
//下面这个函数中的参数numberOfStars是我们总共的星级数,满分是几颗星，isVariable代表是否可以修改星级(YES为可滑动)
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars isVariable:(BOOL)isVariable;

@end
