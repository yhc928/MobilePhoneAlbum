//
//  AssetsGroupTableViewCell.m
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/18.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import "AssetsGroupTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation AssetsGroupTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.assetsLast];
        [self.contentView addSubview:self.assetsDescribeLab];
    }
    return self;
}
-(UIImageView *)assetsLast{
    _assetsLast = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 115 / 1.5 - 20 , 115 / 1.5 - 20)];
    return _assetsLast;
}
-(UILabel *)assetsDescribeLab{
    _assetsDescribeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_assetsLast.frame) + 10, 10, [UIScreen mainScreen].applicationFrame.size.width - CGRectGetMaxX(_assetsLast.frame) - 20, CGRectGetHeight(_assetsLast.frame))];
    return _assetsDescribeLab;
}
-(void)setAssetsDic:(NSDictionary *)assetsDic{
    _assetsDic = assetsDic;
    ALAsset *result = [[_assetsDic objectForKey:@"Asset"] lastObject];
   _assetsLast.image  = [UIImage imageWithCGImage:result.thumbnail];
    
    _assetsDescribeLab.text = [NSString stringWithFormat:@"%@ (%@)", [_assetsDic objectForKey:@"AssetsGroupName"],[_assetsDic objectForKey:@"AssetsCount"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
