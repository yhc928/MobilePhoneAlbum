//
//  AssetsGroupTableViewCell.h
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/18.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsGroupTableViewCell : UITableViewCell
@property (nonatomic ,strong) UIImageView *assetsLast;
@property (nonatomic ,strong) UILabel *assetsDescribeLab;
@property (nonatomic ,strong) NSDictionary *assetsDic;
@end
