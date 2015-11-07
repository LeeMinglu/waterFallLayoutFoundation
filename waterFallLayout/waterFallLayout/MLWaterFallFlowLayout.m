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
static const CGFloat MLColumnMargin = 10;
//设置边距
static const UIEdgeInsets MLEdgeInsetes = {10,10,10,10};

@interface MLWaterFallFlowLayout ()
/**
 *  每列y的最大值
 */
@property (nonatomic, strong) NSMutableArray *columinMaxYArray;

/**
 *  保存每一个cell的属性
 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end

@implementation MLWaterFallFlowLayout
//懒加载最大Y值
- (NSMutableArray *)columinMaxYArray {
    if (!_columinMaxYArray) {
        //[NSMutableArray alloc] init]与[NSMutableArray array]有什么区别? 没有区别
        _columinMaxYArray = [[NSMutableArray alloc] init];
    }
    return _columinMaxYArray;
}
//懒加载各个元素的属性数组
- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

-(void)prepareLayout {
    [super prepareLayout];
    //重置每一列的最大Y坐标
        //移除记录y值所有的对象
    [self.columinMaxYArray removeAllObjects];
        //遍历数组,将数组中的值全部置为0
    for (int i = 0 ; i < MLColumnCount; i++) {
        [self.columinMaxYArray addObject:@(0)];
    }
    
    
    /**/
    //设置每个cell的布局属性
    [self.attrsArray  removeAllObjects];
    
    //获得当前cell的数量
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    //遍历
    for (int i = 0; i < count; i++) {
        //设置indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //根据indexPath获取属性
        UICollectionViewLayoutAttributes *attrs = [self  layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
    
    
}


//设置每个cell的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //1.定义一个数组
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //2.获得collectionView中cell的数量
//    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
//   3. 遍历
    for (int i = 0; i < self.attrsArray.count; i++) {
//        根据indexPath得到layoutAttributes
        UICollectionViewLayoutAttributes *attributes = self.attrsArray[i];
       
        //如果cell与collectionView进行相交就添加到数组中
        if (CGRectIntersectsRect(rect, attributes.frame)) {

            //将布局属性添加到数据中
            [arrayM addObject:attributes];
        }
        
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

#pragma mark 实现内部方法  求出collectionView的contentSize
- (CGSize)collectionViewContentSize {
    CGFloat columnMaxY = [self.columinMaxYArray[0] doubleValue];
    
    for (int i = 1; i < MLColumnCount; i++) {
        CGFloat currentColumnY = [self.columinMaxYArray[i] doubleValue];
        if (columnMaxY < currentColumnY) {
            columnMaxY = currentColumnY;
        }
    }
    
    return CGSizeMake(MLCollectionViewWidth, columnMaxY + MLEdgeInsetes.bottom);
}

@end
