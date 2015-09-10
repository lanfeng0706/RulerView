//
//  DLFRulerView.m
//  RulerView
//
//  Created by 邓岚锋 on 15/9/10.
//  Copyright (c) 2015年 邓岚锋. All rights reserved.
//

#import "DLFRulerView.h"
static CGFloat RulerPointerViewH  = 25.0;
static CGFloat RulerPointerViewW  = 1.0;

@interface DLFRulerView ()<UIScrollViewDelegate>

@property(nonatomic,assign)CGFloat  minValue;   //最小值
@property(nonatomic,assign)CGFloat  maxValue;  //最大值
@property(nonatomic,strong)UIImage  *rulerImage;
@property(nonatomic,assign)CGFloat   rulerMultiple;
@property(nonatomic,assign)rulerViewShowType rulerViewShowType;
@property(nonatomic,strong)UIView *pointerView;
@property(nonatomic,weak)DLFRulerScrollView *rulerView;


@end

@implementation DLFRulerView
-(instancetype)initWithmaxValue: (CGFloat)maxValue minValue:(CGFloat)minValue rulerViewShowType:(rulerViewShowType)rulerViewShwoType andRulerMultiple:(CGFloat)rulerMultiple{
    if ([super init]) {
        _maxValue = maxValue;
        _minValue = minValue;
        _rulerViewShowType = rulerViewShwoType;
        _rulerMultiple = rulerMultiple;
        
        DLFRulerScrollView  *rulerView = [[DLFRulerScrollView alloc]initWithmaxValue:maxValue minValue:minValue rulerViewShowType:rulerViewShwoType andRulerMultiple:rulerMultiple];
        rulerView.delegate = self;
        _rulerView = rulerView;
        [self  addSubview:rulerView];
        
        //添加红点的View
        UIView *pointerView=[[UIView alloc] init];
        pointerView.backgroundColor=[UIColor redColor];
        _pointerView=pointerView;
        [self addSubview:pointerView];
    }
    return self;
}
-(void)setDefaultValue:(CGFloat)defaultValue{
    NSLog(@"%f",defaultValue);
    UIImage *ruleImage=[UIImage imageNamed:@"ruler_width"];
    
    CGFloat formlength=ruleImage.size.width/_rulerMultiple;
    CGFloat gapValue=(defaultValue -_minValue+((CGFloat)_rulerMultiple/2))*formlength;
    
    NSLog(@"%f",ruleImage.size.width);
    if (_rulerViewShowType==rulerViewshowHorizontalType) {
        _rulerView.contentOffset=CGPointMake(gapValue, 0);
    }else{
        _rulerView.contentOffset=CGPointMake(0, gapValue);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取每一个表格的长度
    UIImage *Image=[UIImage imageNamed:@"ruler_width"];
    CGFloat length = Image.size.width/(CGFloat)_rulerMultiple;
    
    //指针指向的刻度
    CGFloat value=0;
    //滑动的刻度值
    CGFloat scrollValue=0;
    
    if ([self.delegate respondsToSelector:@selector(getRulerValue:)]) {
        CGFloat contentOffsetValue=0;
        if (_rulerViewShowType==rulerViewshowHorizontalType) {
            contentOffsetValue=scrollView.contentOffset.x;
        }else{
            contentOffsetValue=scrollView.contentOffset.y;
        }
        scrollValue=(contentOffsetValue/length)-((CGFloat)_rulerMultiple/2);
         value=_minValue+scrollValue;
        [self.delegate getRulerValue:value];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (_rulerViewShowType == rulerViewshowHorizontalType) {  //水平方向
        CGFloat pointerViewH  = RulerPointerViewH;
        CGFloat pointerViewW = RulerPointerViewW;
        CGFloat pointerViewX  = (self.frame.size.width-pointerViewW)/2;
        CGFloat pointerViewY = 0;
        _pointerView.frame = CGRectMake(pointerViewX, pointerViewY, pointerViewW, pointerViewH);
        _rulerView.frame = CGRectMake(self.frame.size.width/2, 0, RulerPointerViewW, self.frame.size.height);
    }else{
        CGFloat pointerViewH  = RulerPointerViewW;
        CGFloat pointerViewW = RulerPointerViewH;
        CGFloat pointerViewX  = 0;
        CGFloat pointerViewY = (self.frame.size.height-pointerViewH)/2;
        _pointerView.frame = CGRectMake(pointerViewX, pointerViewY, pointerViewW, pointerViewH);
        _rulerView.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, RulerPointerViewW);
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[DLFRulerView class]]) {
        return _rulerView;
    }else{
        return view;
     }
}

@end
