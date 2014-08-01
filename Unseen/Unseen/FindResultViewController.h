//
//  FindResultViewController.h
//  Unseen
//
//  Created by Tony on 6/30/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarFindViewController.h"
#import "cellFindResult.h"
#import "CarDetailViewController.h"
#import "SDWebImage/SDWebImageManager.h"
#import "WYStoryboardPopoverSegue.h"
#import "SubSubModelViewController.h"
#import "Car.h"

@protocol FindResultDelegate <NSObject>
-(void)findResultController:(NSString *)carID;
-(void)subSubModelController:(NSString *)subSubModelName;
-(void)listSubSubmodel:(NSArray *)arrSubSubModel;
-(void)pickSubSubModel:(NSString *)subSubModelName;

@end

@interface FindResultViewController : UITableViewController
{
    NSString *typeID,*brandID,*brandName,*modelID,*subModelID;

}

@property (strong,nonatomic) NSString *typeID;
@property (strong,nonatomic) NSString *brandName;
@property (strong,nonatomic) NSString *modelID;
@property (strong,nonatomic) NSString *brandID;
@property (strong,nonatomic) NSString *subModelID;
@property (strong,nonatomic) NSArray *arrSmodel;

@property (strong,nonatomic) NSString *selectCarID;
@property (strong,nonatomic) NSMutableArray *tableItems,*arrResult;
@property (strong,nonatomic) NSMutableDictionary *cachedImages;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong,nonatomic) NSMutableArray *searchResult;

@property (nonatomic,weak) id<FindResultDelegate> delegate;



@end
