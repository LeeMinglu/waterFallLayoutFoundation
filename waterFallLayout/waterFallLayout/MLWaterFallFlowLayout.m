//
//  MLWaterFallFlowLayout.m
//  waterFallLayout
//
//  Created by 李明禄 on 15/11/5.
//  Copyright © 2015年 http://blog.csdn.net/netluoriver. All rights reserved.
//

#import "MLWaterFallFlowLayout.h"
#define  MLCollectionViewWidth self.collectionView.frame.size.width

//设置属性

//设置每行显示的个数
static NSUInteger const MLColumnCount = 3;
//设置行间距
static CGFloat const MLLineMargin = 10;
//设置列间距
static CGFloat const MLColumnMargin = 10;
//设置边距
static UIEdgeInsets MLEdgeInsetes = {10,10,10,10};

@interface MLWaterFallFlowLayout ()
@property (nonatomic, strong) NSMutableArray *columinMaxYArray;
@end

@implementation MLWaterFallFlowLayout

-(void)prepareLayout {
    [super prepareLayout];
    //重置每一列的最大Y坐标
        //移除记录y值所有的对象
    [self.columinMaxYArray removeAllObjects];
        //遍历数组,将数组中的值全部置为0
    for (int i = 0 ; i < MLColumnCount; i++) {
        [self.columinMaxYArray addObject:@(0)];
    }
    
}

//懒加载最大Y值
- (NSMutableArray *)columinMaxYArray {
    if (!_columinMaxYArray) {
        //[NSMutableArray alloc] init]与[NSMutableArray array]有什么区别? 没有区别
        _columinMaxYArray = [[NSMutableArray alloc] init];
    }
    return _columinMaxYArray;
}

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
    
//    找出collectionView中最短的的index和Y值
    CGFloat destColumnMaxY = [self.columinMaxYArray[0]  doubleValue];
    
    //设置一个列的索引值为0
    NSUInteger MLColumnIndex = 0;

    for (int i = 1; i < MLColumnCount; i++) {
        CGFloat columnMaxY = [self.columinMaxYArray[i] doubleValue];
        if (destColumnMaxY > columnMaxY) {
            destColumnMaxY = columnMaxY;
            MLColumnIndex = i;
        }
    }
    
    CGFloat totalColumnSpace =(MLColumnCount - 1) * MLColumnMargin;
    CGFloat width = (MLCollectionViewWidth - MLEdgeInsetes.right - MLEdgeInsetes.left - totalColumnSpace) / MLColumnCount;
    
    CGFloat height = 50 +  arc4random() % 150;
    
    CGFloat x = MLEdgeInsetes.left + MLColumnIndex * (width + MLColumnMargin);
    
    CGFloat y = destColumnMaxY + MLLineMargin;
    attritures.frame = CGRectMake(x, y, width, height);
    
    self.columinMaxYArray[MLColumnIndex] = @(CGRectGetMaxY(attritures.frame));
    
    return attritures;
    
    
    
}

@end
