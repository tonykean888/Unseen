//
//  FavoriteDataAccess.m
//  Unseen
//
//  Created by Tony on 8/1/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "FavoriteDataAccess.h"

#define TableName @"favorite"



@implementation FavoriteDataAccess



-(id)init
{
    self = [super init];
    if (self) {
        db = [FavoriteManager defaultDBManager].database;
    }
    return self;
}



-(void)createDataBase
{
    FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master WHERE type ='table' and name ='%@'",TableName]];
    [set next];
    
    NSInteger count = [set intForColumn:0];
    
    BOOL exisTable = !!count;
    
    if (exisTable) {
        NSLog(@"DB established");
    }else{
        NSString *sql = @"CREATE TABLE IF NOT EXISTS favorite (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , carID VARCHAR, brand VARCHAR, model VARCHAR, detail VARCHAR, submodel VARCHAR, price VARCHAR, thumb TEXT check(typeof(thumb) = 'text') )";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"DB Create fail");
        }else{
            NSLog(@"DB Create success");
        }
    }
    
}

-(void)saveFavoriteCar:(Car *)car
{
    NSMutableString *query = [NSMutableString stringWithFormat:@"INSERT INTO favorite"];
    NSMutableString *keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString *values = [NSMutableString stringWithFormat:@" ("];
    NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:15];
    if (car.carid) {
        [keys appendString:@"carID,"];
        [values appendString:@"?,"];
        [arguments addObject:car.carid];
        NSLog(@"%@",car.carid);
    }
    if (car.brand) {
        [keys appendString:@"brand,"];
        [values appendString:@"?,"];
        [arguments addObject:car.brand];
    }
    if (car.model) {
        [keys appendString:@"model,"];
        [values appendString:@"?,"];
        [arguments addObject:car.model];
    }
    if (car.detail) {
        [keys appendString:@"detail,"];
        [values appendString:@"?,"];
        [arguments addObject:car.detail];
    }
    if (car.subModel) {
        [keys appendString:@"submodel,"];
        [values appendString:@"?,"];
        [arguments addObject:car.subModel];
    }
    if (car.prices) {
        [keys appendString:@"price,"];
        [values appendString:@"?,"];
        [arguments addObject:car.prices];
    }
    if (car.image) {
        [keys appendString:@"thumb,"];
        [values appendString:@"?,"];
        [arguments addObject:car.image];
    }
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    
    NSLog(@"%@",query);
    [db executeUpdate:query withArgumentsInArray:arguments];
}
-(void)deleteFavoriteCarWithID:(NSString *)cid
{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM favorite WHERE carID = '%@'",cid];
    //NSLog(@"%@",query);
    [db executeUpdate:query];
}

- (NSArray *)findCarData
{
    NSString *query = @"SELECT * FROM favorite ORDER BY id";
    
   // NSLog(@"%@",query);
    
    FMResultSet *rs = [db executeQuery:query];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
    while ([rs next]) {
        Car *car = [[Car alloc] init];
        car.carid = [rs stringForColumn:@"carID"];
        car.brand = [rs stringForColumn:@"brand"];
        car.model = [rs stringForColumn:@"model"];
        car.detail = [rs stringForColumn:@"detail"];
        car.subModel = [rs stringForColumn:@"submodel"];
        car.prices = [rs stringForColumn:@"price"];
        car.image = [rs stringForColumn:@"thumb"];
        [array addObject:car];
        
    }
    [rs close];
    return  array;
    
}

@end
