//
//  PhotoGroupViewController.m
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/19.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import "PhotoGroupViewController.h"
#import "AssetsGroupTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoListViewController.h"

@interface PhotoGroupViewController () <UITableViewDataSource ,UITableViewDelegate ,PhotoListViewControllerDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *Datalist;
@property (nonatomic ,strong) NSMutableArray *AssetAry;
@property (nonatomic ,strong) ALAssetsLibrary *assetsLibrary;
@end

@implementation PhotoGroupViewController

-(NSMutableArray *)Datalist{
    if (!_Datalist) {
        _Datalist = [NSMutableArray array];
    }
    return _Datalist;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"照片";
    UIButton *rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 50, 44);
    [rigthBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rigthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rigthBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rigthBtn];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _assetsLibrary = [[ALAssetsLibrary alloc]init];//生成整个photolibrary句柄的实例
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {//获取所有group
        _AssetAry = [[NSMutableArray alloc]init];
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {//从group里面
            NSString* assetType = [result valueForProperty:ALAssetPropertyType];
            if ([assetType isEqualToString:ALAssetTypePhoto]) {
                
                //                NSDictionary *assetUrls = [result valueForProperty:ALAssetPropertyURLs];
                //                NSUInteger assetCounter = 0;
                //                for (NSString *assetURLKey in assetUrls) {
                //                    NSLog(@"Asset URL %lu = %@",(unsigned long)assetCounter,[assetUrls objectForKey:assetURLKey]);
                //                    [assetUrlAry addObject:[assetUrls objectForKey:assetURLKey]];
                //                }
                [self.AssetAry addObject:result];
            }
        }];
        if (group.numberOfAssets > 0) {
            NSString * AssetsGroupName = @"";
            if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"Camera Roll"]) {
                AssetsGroupName = @"相机胶卷";
            }else{
                AssetsGroupName = [group valueForProperty:ALAssetsGroupPropertyName];
            }
            NSDictionary *AssetGroup = @{@"AssetsCount":[NSString stringWithFormat:@"%zi",group.numberOfAssets],@"AssetsGroupName":AssetsGroupName,@"Asset":self.AssetAry};
            [self.Datalist addObject:AssetGroup];
        }
        if (!group) {
            NSArray *newAry = [[self.Datalist reverseObjectEnumerator] allObjects];
            [self.Datalist removeAllObjects];
            [self.Datalist addObjectsFromArray:newAry];
            [_tableView reloadData];
            PhotoListViewController *photoList = [[PhotoListViewController alloc]init];
            photoList.title =[[self.Datalist objectAtIndex:0] objectForKey:@"AssetsGroupName"];
            photoList.photoList = [[self.Datalist objectAtIndex:0] objectForKey:@"Asset"];
            photoList.delegate = self;
            photoList.maximumNumberOfSelection = self.maximumNumberOfSelection;
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:photoList animated:NO];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
}
-(void)cancelAction:(UIButton *)sneder{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Datalist.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AssetsGroupTableViewCell *cell = [[AssetsGroupTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (self.Datalist.count > 0) {
        cell.assetsDic = [self.Datalist objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    PhotoListViewController *photoList = [[PhotoListViewController alloc]init];
    photoList.title =[[self.Datalist objectAtIndex:indexPath.row] objectForKey:@"AssetsGroupName"];
    photoList.photoList = [[self.Datalist objectAtIndex:indexPath.row] objectForKey:@"Asset"];
    photoList.delegate = self;
    photoList.maximumNumberOfSelection = self.maximumNumberOfSelection;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:photoList animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115 / 1.5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didFinishPickingAssets:(NSArray *)assets{
    if ([_delegate respondsToSelector:@selector(assetsPickerController:didFinishPickingAssets:)]){
        
        [_delegate assetsPickerController:self didFinishPickingAssets:assets];
    }
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
