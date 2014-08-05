//
//  AppDelegate.h
//  Unseen
//
//  Created by Tony on 6/25/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FavoriteDataAccess.h"
#import "FavoriteManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     FMDatabase *db;
}
@property (strong, nonatomic) UIWindow *window;





@end
