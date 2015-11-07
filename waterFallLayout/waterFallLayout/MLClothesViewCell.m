//
//  MLClothesViewCell.m
//  waterFallLayout
//
//  Created by 李明禄 on 15/11/7.
//  Copyright © 2015年 http://blog.csdn.net/netluoriver. All rights reserved.
//

#import "MLClothesViewCell.h"
#import "UIImageView+WebCache.h"

@interface MLClothesViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ClothesImageView;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@end

@implementation MLClothesViewCell


- (void)setClothes:(MLClothes *)clothes {
    _clothes = clothes;
    
//    self.ClothesImageView.image = [UIImage imageNamed:clothes.img];
    
    [self.ClothesImageView sd_setImageWithURL:[NSURL URLWithString:clothes.img] placeholderImage:[UIImage imageNamed:@"22.png"]];
    
    self.PriceLabel.text = clothes.price;
}

@end
