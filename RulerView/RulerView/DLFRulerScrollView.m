//
//  DLFRulerScrollView.m
//  RulerView
//
//  Created by 邓岚锋 on 15/9/10.
//  Copyright (c) 2015年 邓岚锋. All rights reserved.
//
#define  DLFminus(maxNuber,mixNuber)   ABS((maxNuber-mixNuber))
#define DLFColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "DLFRulerScrollView.h"

static CGFloat  labelFont =  12.0;
static CGFloat  heightTolabel = 15.0;

@implementation DLFRulerScrollView

-(instancetype)initWithmaxValue: (CGFloat)maxValue minValue:(CGFloat)minValue rulerViewShowType:(rulerViewShowType)rulerViewShwoType andRulerMultiple:(CGFloat)rulerMultiple
{
    if ([super init]) {
        _maxValue = maxValue;
        _minValue = minValue;
        _rulerViewShowType = rulerViewShwoType;
        _rulerMultiple = rulerMultiple;
        
        self.backgroundColor = [UIColor clearColor];
//        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
//        [self setCanCancelContentTouches:NO];
        self.pagingEnabled = NO;
        self.bounces = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.clipsToBounds  = NO;
        self.decelerationRate = 0.7;
        
        //水平方向
        if (_rulerViewShowType == rulerViewshowHorizontalType) {
            _rulerImage = [UIImage imageNamed:@"ruler_width"];
            self.contentSize = CGSizeMake( _rulerImage.size.width*((DLFminus(_maxValue , _minValue)/ _rulerMultiple) +1), self.frame.size.height );
        }else{
            _rulerImage = [UIImage imageNamed:@"ruler_height"];
            self.contentSize  = CGSizeMake(self.frame.size.width, _rulerImage.size.height* ((DLFminus(_maxValue , _minValue)/ _rulerMultiple) +1));
        }
        [self addImageView];
    }
    return self;
}
-(void)addImageView{
    
    for (int  i= 0; i<=DLFminus(_maxValue, _minValue)/_rulerMultiple; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:_rulerImage];
        imageView.tag = i;
        [self addSubview:imageView];
        //创建对应的数字的Label
        UILabel *rulerLable= [[UILabel alloc]init];
        rulerLable.textAlignment=NSTextAlignmentCenter;
        rulerLable.text=[NSString stringWithFormat:@"%.0f",_minValue + i*_rulerMultiple];
        rulerLable.textColor=DLFColor(204, 204, 204);
        rulerLable.font=[UIFont systemFontOfSize:labelFont];
        [self addSubview:rulerLable];
    }
}
//布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    for (UIView *sub in self.subviews) {
            CGPoint centerPoint ;
            CGFloat imageViewH;
            CGFloat imageViewW;
        if ([sub isKindOfClass:[UIImageView class]]) {
            imageViewW = sub.frame.size.width;
            imageViewH = sub.frame.size.height;
            CGFloat  imageViewX;
            CGFloat  imageViewY;
            //水平方向
            imageViewX = ( _rulerViewShowType == rulerViewshowHorizontalType)? imageViewW*sub.tag : 0;
            imageViewY = ( _rulerViewShowType == rulerViewshowHorizontalType)? 0 : imageViewH*sub.tag;
            sub.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
            centerPoint = sub.center;
        }else if([sub isKindOfClass:[UILabel class]]){
            CGFloat LableW;
            CGFloat LableH;
            CGFloat LableX;
            CGFloat LableY;
            if (_rulerViewShowType == rulerViewshowHorizontalType) {  //水平方向
                LableW = 60;
                LableH = 20;
                LableX = centerPoint.x - LableW/2;
                LableY = imageViewH+ heightTolabel;
            }else{
                LableW = 60;
                LableH = 30;
                LableX=imageViewW-heightTolabel;   //>???
                LableY=centerPoint.y-LableH/2;
            }
            sub.frame = CGRectMake(LableX, LableY, LableW, LableH);
        }
    }
    
}
@end
