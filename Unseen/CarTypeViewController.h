//
//  CarTypeViewController.h
//  Unseen
//
//  Created by Tony on 6/25/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarTypeViewControllerDelegate <NSObject>
-(void)cartypeViewCOntroller:(NSString *)selectedCarType forCarTypeID:(NSString *)selectedCarTypeID;
@end

@interface CarTypeViewController : UITableViewController
@property (nonatomic,strong) NSString *selectedCarType;
@property (nonatomic,strong) NSString *selectedCarTypeID;


@property (nonatomic,weak) id<CarTypeViewControllerDelegate> delegate;

@end
