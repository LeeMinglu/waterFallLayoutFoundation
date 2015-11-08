//
//  MLClothesViewController.m
//  waterFallLayout
//
//  Created by 李明禄 on 15/11/5.
//  Copyright © 2015年 http://blog.csdn.net/netluoriver. All rights reserved.
//

#import "MLClothesViewController.h"
#import "MLWaterFallFlowLayout.h"
#import "MLClothesViewCell.h"
#import "MLClothes.h"
#import "MJRefresh.h"
#import "MJExtension.h"

@interface MLClothesViewController ()<MLWaterFallFlowLayoutDelegate>

@property (nonatomic, strong) NSMutableArray *clothesArray;

@end

@implementation MLClothesViewController

static NSString * const reuseIdentifier = @"ClothesCell";

- (NSMutableArray *)clothesArray {
    if (!_clothesArray) {
        _clothesArray = [NSMutableArray array];
    }
    return _clothesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //加载数据
    NSArray *array = [MLClothes objectArrayWithFilename:@"clothes.plist"];
    
    [self.clothesArray addObjectsFromArray:array];
   
    //切换布局
    MLWaterFallFlowLayout *layout = [[MLWaterFallFlowLayout alloc] init];
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor grayColor];
    
    layout.delegate = self;
    
//     上拉刷新数据
    __weak typeof(self) weakSelf = self;
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 加载数据
        NSArray *tempArray = [MLClothes objectArrayWithFilename:@"clothes.plist"];
        [weakSelf.clothesArray insertObjects:tempArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempArray.count)]];
        [weakSelf.collectionView reloadData];
        
        // 结束刷新
        [weakSelf.collectionView.header endRefreshing];
    }];
    
    
//    下拉刷新数据
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //获取数据
        NSArray *tempArray = [MLClothes objectArrayWithFilename:@"clothes.plist"];
        
        [weakSelf.clothesArray addObjectsFromArray:tempArray];
        
        [weakSelf.collectionView reloadData];
        
        [weakSelf.collectionView.footer endRefreshing];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.clothesArray.count;
}
 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLClothesViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
//    cell.backgroundColor = [UIColor redColor];
    cell.clothes = self.clothesArray[indexPath.item];
    
    return cell;
}


// MARK: 实现MLWaterFallFlowLayout
- (CGFloat)waterFallFlowLayout:(MLWaterFallFlowLayout *)waterFallFlow heightForRowAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)width {
    
    MLClothes *clothes = self.clothesArray[indexPath.item];
    
//    根据item的宽度计算
    return clothes.h * width / clothes.w;
    
}


@end
