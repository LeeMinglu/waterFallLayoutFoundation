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
#import "MJExtension.h"

@interface MLClothesViewController ()

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
    
    self.collectionView.collectionViewLayout = [[MLWaterFallFlowLayout alloc] init];
    
    //加载数据
    NSArray *array = [MLClothes objectArrayWithFilename:@"clothes.plist"];
    
    [self.clothesArray addObjectsFromArray:array];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}


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



@end
