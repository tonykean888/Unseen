//
//  ttt.h
//  Unseen
//
//  Created by Tony on 7/1/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarFindViewController.h"
#import "CarModelViewController.h"
#import "CarBrandViewController.h"
#import "CarTypeViewController.h"

@interface ttt : UIViewController
{
    NSString *typeID,*brandName,*modelID;
}

@property (retain,nonatomic) NSString *typeID;
@property (retain,nonatomic) NSString *brandName;
@property (retain,nonatomic) NSString *modelID;

@end
