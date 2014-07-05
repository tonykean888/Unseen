//
//  CarModelViewController.h
//  Unseen
//
//  Created by Tony on 6/28/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarModelViewControllerDelegate <NSObject>

-(void)carModelViewControllers:(NSString *)selectedCarModel forCarModelID:(NSString *)selectedCarModelID;
@end
@interface CarModelViewController : UITableViewController

@property (nonatomic,weak) NSString *selectedCarModelID;
@property (nonatomic,weak) NSString *selectedCarModel;
@property (nonatomic,weak) NSString *selCarBrand;
@property (nonatomic,weak) NSString *selCarBrandID;
@property (nonatomic,weak) NSString *selCarTypeID;

@property (nonatomic,strong)id<CarModelViewControllerDelegate> delegate;
@end
