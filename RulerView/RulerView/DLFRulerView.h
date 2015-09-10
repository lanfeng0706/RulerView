//
//  DLFRulerView.h
//  RulerView
//
//  Created by 邓岚锋 on 15/9/10.
//  Copyright (c) 2015年 邓岚锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLFRulerScrollView.h"

@class DLFRulerView;
@protocol DLFRulerViewDelegate <NSObject>
@optional

-(void)getRulerValue:(CGFloat)rulerValue;

@end
@interface DLFRulerView : UIView
@property(nonatomic,weak)id<DLFRulerViewDelegate>delegate;
@property(nonatomic,assign)CGFloat defaultValue;  //默认值
-(instancetype)initWithmaxValue: (CGFloat)maxValue minValue:(CGFloat)minValue rulerViewShowType:(rulerViewShowType)rulerViewShwoType andRulerMultiple:(CGFloat)rulerMultiple;

@end
