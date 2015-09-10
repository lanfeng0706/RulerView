//
//  DLFViewController.m
//  RulerView
//
//  Created by 邓岚锋 on 15/9/10.
//  Copyright (c) 2015年 邓岚锋. All rights reserved.
//

#import "DLFViewController.h"
#import "DLFRulerView.h"

static CGFloat const rulerMultiple=10;
@interface DLFViewController ()<DLFRulerViewDelegate>
@property(nonatomic,strong)UILabel *valueLable;
@property(nonatomic,strong)DLFRulerView *rulerview;
@end

@implementation DLFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect1=CGRectMake(20, 200, self.view.frame.size.width-40, 55);
    DLFRulerView *rulerView = [[DLFRulerView alloc]initWithmaxValue:200 minValue:20 rulerViewShowType: rulerViewshowHorizontalType andRulerMultiple:rulerMultiple];
    _rulerview = rulerView;
    rulerView.defaultValue = 90;
//    rulerView.backgroundColor = [UIColor orangeColor]; 
    rulerView.clipsToBounds = YES;
    rulerView.frame = rect1;
    rulerView.delegate = self;
    [self.view addSubview:rulerView];
    
    
    
    UIButton *statusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    statusBtn.backgroundColor=[UIColor redColor];
    statusBtn.frame=CGRectMake(self.view.frame.size.width-80, 60, 40, 40);
    [statusBtn setTitle:@"垂直" forState:UIControlStateNormal];
    [statusBtn setTitle:@"水平" forState:UIControlStateSelected];
    [statusBtn addTarget:self action:@selector(changeRulerShowType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:statusBtn];
    
    UILabel *valueLable=[[UILabel alloc] init];
    _valueLable=valueLable;
    valueLable.font=[UIFont systemFontOfSize:18];
    valueLable.frame=CGRectMake(20, 60, 150, 80);
    valueLable.textColor=[UIColor blackColor];
    valueLable.text=@"0";
    [self.view  addSubview:valueLable];

}

-(void)changeRulerShowType:(UIButton *)button{
    button.selected=!button.selected;
    [_rulerview removeFromSuperview];
    CGRect rect1=CGRectMake(20,200, self.view.frame.size.width-40, 50);
    CGRect rect2=CGRectMake(150, 50, 50, self.view.frame.size.height-100);
    if ( button.selected) {
       _rulerview = [[DLFRulerView alloc]initWithmaxValue:500 minValue:40 rulerViewShowType: rulerViewshowVerticalType andRulerMultiple:rulerMultiple];
        _rulerview.frame=rect2;
        _rulerview.clipsToBounds = YES;
    }else{
        [_rulerview removeFromSuperview];
        _rulerview=[[DLFRulerView alloc]initWithmaxValue:500 minValue:40 rulerViewShowType: rulerViewshowHorizontalType andRulerMultiple:rulerMultiple];
        _rulerview.frame=rect1;
        _rulerview.clipsToBounds = YES;
    }
    _rulerview.delegate=self;
    _rulerview.defaultValue=85;
    _rulerview.backgroundColor=[UIColor yellowColor];
    [self.view  addSubview:_rulerview];
    
}
-(void)getRulerValue:(CGFloat)rulerValue
{
    NSLog(@"%f",rulerValue);
    _valueLable.text = [NSString stringWithFormat:@"%.2f",rulerValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
