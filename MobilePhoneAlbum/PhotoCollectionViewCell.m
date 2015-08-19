//
//  PhotoCollectionViewCell.m
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/19.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
        [self.contentView addSubview:_imageView];
       
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(self.frame.size.width - 50, 0, 50, 23);
        [_selectBtn setImage:[UIImage imageNamed:@"radio_no"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"radio_yes"] forState:UIControlStateSelected];
        [_selectBtn setBackgroundColor:[UIColor clearColor]];
        [_selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [self.contentView addSubview:_selectBtn];
    }
    return self;
}
-(void)setSelectTag:(NSInteger)selectTag{
    _selectTag = selectTag;
    _selectBtn.tag = selectTag;
}
-(void)selectClick:(UIButton *)sender{
    
    if ([_delegate respondsToSelector:@selector(PhotoBtnClick:Selected:selectedBtn:)]) {
        
        [_delegate PhotoBtnClick:sender.tag Selected:sender.selected selectedBtn:sender];
        
    }
    [sender setSelected:!sender.selected];
}
@end
