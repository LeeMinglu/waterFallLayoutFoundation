//
//  MLClothesViewController.m
//  waterFallLayout
//
//  Created by 李明禄 on 15/11/5.
//  Copyright © 2015年 http://blog.csdn.net/netluoriver. All rights reserved.
//

#import "MLClothesViewController.h"
#import "MLWaterFallFlowLayout.h"

@interface MLClothesViewController ()

@end

@implementation MLClothesViewController

static NSString * const reuseIdentifier = @"ClothesCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.collectionViewLayout = [[MLWaterFallFlowLayout alloc] init];

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

    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}



@end
