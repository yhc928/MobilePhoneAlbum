//
//  PhotoListViewController.m
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/19.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import "PhotoListViewController.h"
#import "PhotoCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define ScreenHeight  [UIScreen mainScreen].applicationFrame.size.height
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
@interface PhotoListViewController () <UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout ,PhotoCollectionViewCellDelegate>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *dataList;

@property (nonatomic ,strong) UIButton *previewBtn;
@property (nonatomic ,strong) UIButton *doneBtn;
//@property (nonatomic ,strong) UIView *countView;
@property (nonatomic ,strong) UILabel *countLab;
@end

@implementation PhotoListViewController

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 50, 44);
    [rigthBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rigthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rigthBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rigthBtn];
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    CGSize size=CGSizeMake([[UIScreen mainScreen] bounds].size.width / 4 - 5, [[UIScreen mainScreen] bounds].size.width / 4 - 5);
    flowLayout.itemSize=size;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, CGRectGetHeight(self.view.frame) - 44) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoColl"];
     self.collectionView.delegate = self;
     self.collectionView.dataSource = self;
     [self.view addSubview:self.collectionView];
   
    //底部
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 44 + 20, ScreenHeight, 44)];
    View.backgroundColor = RGBA(247, 247, 247, 1);
    [self.view addSubview:View];
    
    _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewBtn.frame = CGRectMake(0, 0, 60, 44);
    [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    _previewBtn.userInteractionEnabled = NO;
    [_previewBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    _previewBtn.adjustsImageWhenHighlighted = NO;
    [_previewBtn setTitleColor:RGBA(189, 189, 189, 1) forState:UIControlStateNormal];
    [_previewBtn addTarget:self action:@selector(previewAction:) forControlEvents:UIControlEventTouchUpInside];
    [View addSubview:_previewBtn];
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneBtn.frame = CGRectMake(ScreenWidth - 60, 0, 60, 44);
    [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    _doneBtn.userInteractionEnabled = NO;
    [_doneBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    _doneBtn.adjustsImageWhenHighlighted = NO;
    [_doneBtn setTitleColor:RGBA(171, 222, 175, 1) forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(doneClick:) forControlEvents:UIControlEventTouchUpInside];
    [View addSubview:_doneBtn];
  
    _countLab = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 55 - 20, 11, 20, 20)];
    _countLab.backgroundColor = RGBA(26, 177, 10, 1);
    _countLab.hidden = YES;
    _countLab.layer.cornerRadius = 10;
    _countLab.layer.masksToBounds = YES;
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.font = [UIFont systemFontOfSize:17];
    _countLab.textColor = [UIColor whiteColor];
    [View addSubview:_countLab];
    
}
-(void)previewAction:(UIButton *)sender{

}
-(void)doneClick:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(didFinishPickingAssets:)]) {
        [_delegate didFinishPickingAssets:self.dataList];
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoColl" forIndexPath:indexPath];
    ALAsset *result = [self.photoList objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:result.thumbnail];
    cell.delegate = self;
    cell.selectTag = indexPath.row;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
}
-(void)PhotoBtnClick:(NSInteger)selectRow Selected:(BOOL)selected selectedBtn:(UIButton *)sender{
    if (!selected) {
        if (self.dataList.count == self.maximumNumberOfSelection) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"你最多只能选择%zi张照片",self.maximumNumberOfSelection] message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alertView show];
            [sender setSelected:!sender.selected];
            return;
        }
        [self.dataList addObject:[self.photoList objectAtIndex:selectRow]];
    }else{
        [self.dataList removeObject:[self.photoList objectAtIndex:selectRow]];
    }
    if (self.dataList.count > 0) {
        _previewBtn.userInteractionEnabled = YES;
        [_previewBtn setTitleColor:RGBA(17, 17, 17, 1) forState:UIControlStateNormal];
        _doneBtn.userInteractionEnabled = YES;
        [_doneBtn setTitleColor:RGBA(9, 176, 8, 1) forState:UIControlStateNormal];
        _countLab.hidden = NO;
        _countLab.text = [NSString stringWithFormat:@"%zi",self.dataList.count];
    }else{
        _previewBtn.userInteractionEnabled = NO;
        [_previewBtn setTitleColor:RGBA(189, 189, 189, 1) forState:UIControlStateNormal];
        _doneBtn.userInteractionEnabled = NO;
        [_doneBtn setTitleColor:RGBA(171, 222, 175, 1) forState:UIControlStateNormal];
        _countLab.hidden = YES;
    }
}
-(void)cancelAction:(UIButton *)sneder{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
