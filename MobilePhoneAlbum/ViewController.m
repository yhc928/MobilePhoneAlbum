//
//  ViewController.m
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/18.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import "ViewController.h"
#import "PhotoGroupViewController.h"

@interface ViewController ()<AssetsPickerViewControllerDelegate>

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BtnClick:(id)sender {
    PhotoGroupViewController *photoGroup = [[PhotoGroupViewController alloc]init];
    photoGroup.delegate = self;
    photoGroup.maximumNumberOfSelection = 9;
    UINavigationController *Nav = [[UINavigationController alloc]initWithRootViewController:photoGroup];
    
    [self presentViewController:Nav animated:YES completion:^{
        
    }];
}
-(void)assetsPickerController:(PhotoGroupViewController *)picker didFinishPickingAssets:(NSArray *)assets{
    NSLog(@"%@",assets);
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
