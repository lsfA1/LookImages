//
//  PicturesView.m
//  ChMedicineProject
//  cell中图片点击展示大图
//  Created by 李少锋 on 2018/11/19.
//  Copyright © 2018年 zh. All rights reserved.
//

#import "PicturesView.h"
#import "ShowImageView.h"

static CGRect nowPictureFrame;

#define HaveAndHiddenImageViewY 100

#define OnePictureSpace 20.0f  //图片之间的空隙

@interface PicturesView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,copy)NSArray *imageArray;/** 图片数组(展示图片的字符串) */

@property(nonatomic,copy)NSMutableArray *imageFrameArray;/** 图片在cell中的frame的数组 */

@end

@implementation PicturesView

+(instancetype)showImage:(NSInteger)selectIndex andImagesArray:(NSArray *)imagesArray andImageFrameArray:(NSMutableArray *)imageFrameArray{
    PicturesView *picturesView;
    if(!picturesView){
        picturesView=[[PicturesView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    [picturesView initViews:selectIndex andImagesArray:imagesArray andFrame:imageFrameArray];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [window addSubview:picturesView];
    return picturesView;
}

-(void)initViews:(NSInteger)index andImagesArray:(NSArray *)imagesArray andFrame:(NSMutableArray *)frameArray{
    _imageArray=imagesArray;
    _imageFrameArray=frameArray;
    nowPictureFrame = CGRectFromString(_imageFrameArray[index]);
    self.backgroundColor=[UIColor colorWithWhite:0 alpha:1];
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.userInteractionEnabled=YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate=self;
    _scrollView=scrollView;
    scrollView.backgroundColor=[UIColor colorWithWhite:0 alpha:1];
    [self addSubview:scrollView];
    
    scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*imagesArray.count, SCREEN_HEIGHT);
    
    CGFloat space = OnePictureSpace;
    CGFloat itemWidth = scrollView.bounds.size.width + space * 2.0;
    for (NSInteger i=0; i<imagesArray.count; i++) {
        ShowImageView *showImageView=[[ShowImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(scrollView.bounds)*i, 0, CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds)) andImageName:imagesArray[i]];
        showImageView.userInteractionEnabled=YES;
        
        showImageView.tag=i;
        [scrollView addSubview:showImageView];
        CGRect frame = scrollView.bounds;
        frame.origin.x = itemWidth * i;
        frame.origin.y = 0;
        frame.size.width = itemWidth;
        showImageView.frame = CGRectInset(frame, space, 0);
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
        [showImageView addGestureRecognizer:tap];
        UIView *singleTapView = [tap view];
        singleTapView.tag = i;
    }
    scrollView.frame = CGRectMake(-space, 0, itemWidth, SCREEN_HEIGHT);
    CGSize pageViewSize = scrollView.bounds.size;
    [scrollView setContentSize:CGSizeMake(itemWidth * imagesArray.count, pageViewSize.height)];
    scrollView.contentOffset = CGPointMake(itemWidth*index, 0);
    
    UIImageView *img=[[UIImageView alloc]init];
    img.frame=nowPictureFrame;
    [img setImageUrlStr:imagesArray[index] andImgType:imageSize16_9];
    [self addSubview:img];
    scrollView.hidden=YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        img.frame=CGRectMake(0, HaveAndHiddenImageViewY, SCREEN_WIDTH, SCREEN_HEIGHT-HaveAndHiddenImageViewY*2);
    } completion:^(BOOL finished) {
        [img removeFromSuperview];
        scrollView.hidden=NO;
    }];
}

//设置当前查看的图片在cell中的frame，用于点击消失后之后复原到cell中的原有位置
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/SCREEN_WIDTH;
    nowPictureFrame = CGRectFromString(_imageFrameArray[index]);
}

-(void)hideImage:(UITapGestureRecognizer *)tap{
    NSInteger index=[tap view].tag;
    UIImageView *img=[[UIImageView alloc]init];
    img.frame=CGRectMake(0, HaveAndHiddenImageViewY, SCREEN_WIDTH, SCREEN_HEIGHT-HaveAndHiddenImageViewY*2);
    [img setImageUrlStr:_imageArray[index] andImgType:imageSize16_9];
    [self addSubview:img];
    _scrollView.hidden=YES;
    self.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    _scrollView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    [UIView animateWithDuration:0.3 animations:^{
        img.frame=nowPictureFrame;
    } completion:^(BOOL finished) {
        [img removeFromSuperview];
        [_scrollView removeFromSuperview];
        for(UIView *subView in _scrollView.subviews){
            [subView removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
