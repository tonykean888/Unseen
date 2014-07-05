//
//  CarBrandViewController.h
//  Unseen
//
//  Created by Tony on 6/26/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarTypeViewController.h"

@protocol CarBrandViewControllerDelegate <NSObject>


-(void)carbrandViewController:(NSString *)selectedCarBrand forCarBrandID:(NSString *)selectedCarBrandID;

@end

@interface CarBrandViewController : UITableViewController

@property (nonatomic,strong) NSString *selectedCarBrand;
@property (nonatomic,strong) NSString *selectedCarBrandID;
@property (nonatomic,strong) NSString *selCarTypeID;

@property (nonatomic,weak) id<CarBrandViewControllerDelegate> delegate;

@end
