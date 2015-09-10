//
//  DLFRulerScrollView.h
//  RulerView
//
//  Created by 邓岚锋 on 15/9/10.
//  Copyright (c) 2015年 邓岚锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(int, rulerViewShowType){
    /**
     *  水平方向
     */
    rulerViewshowHorizontalType=0,
    /**
     *  垂直方向
     */
    rulerViewshowVerticalType =1,
};

@interface DLFRulerScrollView  : UIScrollView
@property(nonatomic,assign)CGFloat  minValue;   //最小值
@property(nonatomic,assign)CGFloat  maxValue;  //最大值
@property(nonatomic,strong)UIImage  *rulerImage;
@property(nonatomic,assign)CGFloat   rulerMultiple;
@property(nonatomic,assign)rulerViewShowType rulerViewShowType;


-(instancetype)initWithmaxValue: (CGFloat)maxValue minValue:(CGFloat)minValue rulerViewShowType:(rulerViewShowType)rulerViewShwoType andRulerMultiple:(CGFloat)rulerMultiple;



@end
