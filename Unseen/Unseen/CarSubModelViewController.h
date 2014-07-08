//
//  CarSubModelViewController.h
//  Unseen
//
//  Created by Tony on 7/8/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarSubModelViewControllerDelegate <NSObject>

-(void)CarSubModelViewController:(NSString *)selectedCarSubModel forCarSubModelID: (NSString *) selectedCarSubModelID;


@end

@interface CarSubModelViewController : UITableViewController


@property (nonatomic,weak) NSString *selectedCarSubModelID;
@property (nonatomic,weak) NSString *selectedCarSubModel;

@property (nonatomic,weak) NSString *selCarModelID;

@property (nonatomic,strong) id<CarSubModelViewControllerDelegate> delegate;
@end
