//
//  ShowImageView.m
//  ChMedicineProject
//  图片点击展示大图
//  Created by 李少锋 on 2018/11/19.
//  Copyright © 2018年 zh. All rights reserved.
//

#import "ShowImageView.h"

#define HaveAndHiddenImageViewY 100

#define ScrollViewMinimumZoomScale  1.0f

#define ScrollViewMaximumZoomScale  2.0f

@interface ShowImageView ()<UIScrollViewDelegate,UIActionSheetDelegate>

@property(nonatomic,copy)NSArray *imageArray;/** 图片数组 */

@property(nonatomic,strong)UIImageView *nowImageView;/** 当前展示的图片 */

@property(nonatomic,strong)UIActionSheet *actionSheet;/** 保存图片alertView */

@end

@implementation ShowImageView

-(instancetype)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName{
    self=[super initWithFrame:frame];
    if(self){
        [self initScrollView:imageName];
    }
    return self;
}

-(void)initScrollView:(NSString *)imageName{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.userInteractionEnabled=YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate=self;
    [scrollView setMinimumZoomScale:ScrollViewMinimumZoomScale];
    [scrollView setMaximumZoomScale:ScrollViewMaximumZoomScale];
    scrollView.backgroundColor=[UIColor colorWithWhite:0 alpha:1];
    [self addSubview:scrollView];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, HaveAndHiddenImageViewY, CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds)-HaveAndHiddenImageViewY*2)];
    imageView.userInteractionEnabled=YES;
    [imageView setImageUrlStr:imageName andImgType:imageSize16_9];
    _nowImageView=imageView;
    [scrollView addSubview:imageView];
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.nowImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.nowImageView.center = [self centerOfScrollViewContent:scrollView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
