//
//  FavoriteDataAccess.h
//  Unseen
//
//  Created by Tony on 8/1/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteManager.h"
#import "Car.h"




@interface FavoriteDataAccess : NSObject
{
    
    FMDatabase *db;
}

-(void) createDataBase;
-(void) saveFavoriteCar:(Car *)car;
-(void) deleteFavoriteCarWithID:(NSString *) cid;
-(NSArray *) findCarData;

@end
