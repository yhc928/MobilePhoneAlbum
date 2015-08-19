//
//  PhotoCollectionViewCell.h
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/19.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoCollectionViewCell;

@protocol PhotoCollectionViewCellDelegate <NSObject>

- (void)PhotoBtnClick:(NSInteger)selectRow Selected:(BOOL)selected selectedBtn:(UIButton *)sender;

@end
@interface PhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UIButton *selectBtn;
@property (nonatomic ,assign) NSInteger selectTag;
@property (nonatomic ,weak) id<PhotoCollectionViewCellDelegate> delegate;
@end
