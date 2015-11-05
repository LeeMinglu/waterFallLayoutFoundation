//
//  MLWaterFallFlowLayout.m
//  waterFallLayout
//
//  Created by 李明禄 on 15/11/5.
//  Copyright © 2015年 http://blog.csdn.net/netluoriver. All rights reserved.
//

#import "MLWaterFallFlowLayout.h"

@implementation MLWaterFallFlowLayout

//设置每个cell的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //定义一个数组
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //获得collectionView中cell的数量
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
//    遍历
    for (int i = 0; i < count; i++) {
        
         //设置i位置的indexPath,一定要用[NSIndexPath indexPathForItem:i inSection:0],否则不会出现cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
    
//        根据indexPath得到layoutAttributes
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    //将布局属性添加到数据中
        [arrayM addObject:attributes];
    }
//    返回生成属性的数组
    return arrayM;
}

//设置indexPath位置的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attritures = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置属性
    attritures.size = CGSizeMake(100, 100);
    attritures.center = CGPointMake(100, 100);
    return attritures;
    
    
    
}

@end
