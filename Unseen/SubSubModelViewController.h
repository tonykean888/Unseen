//
//  SubSubModelViewController.h
//  Unseen
//
//  Created by Tony on 7/26/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindResultViewController.h"
#import "cellSubSubModel.h"
#import "WYStoryboardPopoverSegue.h"

@class SubSubModelViewController;

@protocol SubSubModelDelegate <NSObject>
@optional

-(void)subSubModelViewControllerDidCancel:(SubSubModelViewController *)controller;

-(void)subSubModelViewController:(SubSubModelViewController *)controller didPicksubSubModel:(NSString *)subSubModelName;

@end

@interface SubSubModelViewController:UITableViewController
{
    
}
- (IBAction)btnCancelPick:(id)sender;

- (IBAction)btnPickSubModel:(id)sender;


@property (nonatomic,weak) NSArray *listSubModel;
@property (nonatomic,weak) NSString *selectSubSubModel;
@property(nonatomic,weak) id<SubSubModelDelegate> delegate;
@end


