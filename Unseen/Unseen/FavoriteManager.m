//
//  FavoriteManager.m
//  Unseen
//
//  Created by Tony on 8/5/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "FavoriteManager.h"

#define DBname @"favorite.sqlite"

@interface FavoriteManager()

@end


@implementation FavoriteManager

static FavoriteManager * _sharedDBManager;
+(FavoriteManager *) defaultDBManager
{
    if (!_sharedDBManager) {
        _sharedDBManager = [[FavoriteManager alloc] init];
        
    }
    return _sharedDBManager;
    
}

-(id)init
{
    self = [super init];
    if (self) {
        int state = [self initializeDBWithName:DBname];
        if (state == -1) {
            NSLog(@"intialize database failed");
        }else{
            //db = [FavoriteDataAccess defaultDBManager].database;
            NSLog(@"intialize database success");
        }
        
    }
    return self;
}

- (int)initializeDBWithName :(NSString *) name
{
    if (!name) {
        return  -1;
        
    }

    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    documentName = [documentDir stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:documentName];
    [self connect];
    if (!exist) {
        return 0;
    }else{
        return 1;
    }
    
    
}

-(void) connect
{
    if (!_database) {
        _database = [[FMDatabase alloc] initWithPath:documentName];
        
    }
    
      if (![_database open]) {
        NSLog(@"Can not open database");
    }
    
}

-(void)close
{
    [_database close];
    _sharedDBManager = nil;
}





@end
