//
//  PhotoListViewController.h
//  MobilePhoneAlbum
//
//  Created by Apple on 15/8/19.
//  Copyright (c) 2015年 aladdin-holdings.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoListViewController;

@protocol PhotoListViewControllerDelegate <NSObject>

- (void)didFinishPickingAssets:(NSArray *)assets;

@end

@interface PhotoListViewController : UIViewController
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (nonatomic ,strong) NSArray *photoList;
@property (nonatomic ,weak) id<PhotoListViewControllerDelegate> delegate;
@end
