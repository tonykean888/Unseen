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

@protocol FindResultDelegate <NSObject>
-(void)findResultController:(NSString *)carID;

@end

@interface FindResultViewController : UITableViewController
{
    NSString *typeID,*brandID,*brandName,*modelID;
}

@property (retain,nonatomic) NSString *typeID;
@property (retain,nonatomic) NSString *brandName;
@property (retain,nonatomic) NSString *modelID;
@property (retain,nonatomic) NSString *brandID;

@property (strong,nonatomic) NSString *selectCarID;

@property (nonatomic,weak) id<FindResultDelegate> delegate;

@end
