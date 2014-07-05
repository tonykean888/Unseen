//
//  CarFindViewController.h
//  Unseen
//
//  Created by Tony on 6/25/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarTypeViewController.h"
#import "CarBrandViewController.h"
#import "CarModelViewController.h"
#import "FindResultViewController.h"

@interface CarFindViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *lblSelCarType;
@property (weak, nonatomic) IBOutlet UILabel *lblSelCarBrand;
@property (weak, nonatomic) IBOutlet UILabel *lblSelCarModel;

- (IBAction)btnFindCar:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnFind;

@end
