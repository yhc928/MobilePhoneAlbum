//
//  PhotoGroupViewController.h
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/19.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoGroupViewController;

@protocol AssetsPickerViewControllerDelegate <NSObject>

- (void)assetsPickerController:(PhotoGroupViewController *)picker didFinishPickingAssets:(NSArray *)assets;

@end
@interface PhotoGroupViewController : UIViewController
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (nonatomic ,weak) id<AssetsPickerViewControllerDelegate> delegate;
@end
