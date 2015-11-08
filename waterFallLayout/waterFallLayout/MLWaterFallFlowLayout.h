//
//  MLWaterFallFlowLayout.h
//  waterFallLayout
//
//  Created by 李明禄 on 15/11/5.
//  Copyright © 2015年 http://blog.csdn.net/netluoriver. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLWaterFallFlowLayout;

@protocol MLWaterFallFlowLayoutDelegate <NSObject>

@required
/**
 *  返回indexPath位置cell的高度
 */
- (CGFloat)waterFallFlowLayout:(MLWaterFallFlowLayout *)waterFallFlow
       heightForRowAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width;

@optional
/**
 *  返回布局的行间距
 */
- (CGFloat)rowSpacingInWaterfallFlowLayout:(MLWaterFallFlowLayout *)layout;

/**
 *  返回布局的列间距
 */
- (CGFloat)columnSpacingInWaterfallFlowLayout:(MLWaterFallFlowLayout *)layout;

/**
 *  返回布局的列数
 */
- (CGFloat)columnCountInWaterfallFlowLayout:(MLWaterFallFlowLayout *)layout;

/**
  *  返回布局的列间距
  */
- (UIEdgeInsets)edgeInsetsInWaterfallFlowLayout:(MLWaterFallFlowLayout *)layout;

@end

@interface MLWaterFallFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<MLWaterFallFlowLayoutDelegate> delegate;

@end
