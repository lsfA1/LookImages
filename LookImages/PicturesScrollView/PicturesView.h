//
//  PicturesView.h
//  ChMedicineProject
//  cell中图片点击展示大图
//  Created by 李少锋 on 2018/11/19.
//  Copyright © 2018年 zh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PicturesView : UIView


/**
 显示图片查看view

 @param selectIndex 点击某个cell中item的下标
 @param imagesArray 图片array(存放图片的地址)
 @param imageFrameArray 图片在cell中原有位置frame的array
 @return PicturesView对象
 */
+(instancetype)showImage:(NSInteger)selectIndex andImagesArray:(NSArray *)imagesArray andImageFrameArray:(NSMutableArray *)imageFrameArray;

@end

NS_ASSUME_NONNULL_END
