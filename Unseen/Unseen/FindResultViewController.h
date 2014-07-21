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




@protocol FindResultDelegate <NSObject>
-(void)findResultController:(NSString *)carID;

@end

@interface FindResultViewController : UITableViewController
{
    NSString *typeID,*brandID,*brandName,*modelID,*subModelID;

}

@property (retain,nonatomic) NSString *typeID;
@property (retain,nonatomic) NSString *brandName;
@property (retain,nonatomic) NSString *modelID;
@property (retain,nonatomic) NSString *brandID;
@property (retain,nonatomic) NSString *subModelID;

@property (strong,nonatomic) NSString *selectCarID;
@property (strong,nonatomic) NSMutableArray *tableItems;
@property (strong,nonatomic) NSMutableDictionary *cachedImages;


@property (nonatomic,weak) id<FindResultDelegate> delegate;

@end
