//
//  FavoriteManager.h
//  Unseen
//
//  Created by Tony on 8/5/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Car.h"
#import "FMDatabaseAdditions.h"

@class FMDatabase;

@interface FavoriteManager : NSObject
{
    NSString *documentName;

}

@property (nonatomic,readonly) FMDatabase *database;

+(FavoriteManager *) defaultDBManager;
-(void) close;


@end
