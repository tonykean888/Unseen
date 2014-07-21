//
//  FavoriteViewController.m
//  Unseen
//
//  Created by Tony on 7/18/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()
{
    NSMutableArray *arrFavcar;
    //NSDictionary *dic;
}
@end

@implementation FavoriteViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *dbname = @"favorite_db.sqlite";
    NSString *dbpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbname];
    
  
    
    arrFavcar = [[NSMutableArray alloc] init];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbpath];
    [database open];
    
    FMResultSet *rs = [database executeQuery:@"SELECT * FROM favorite_db ORDER BY id"];
    while ([rs next]) {
        NSDictionary *dic = [rs resultDictionary];
        [arrFavcar addObject:dic];
//        
//        NSString *sid   = [rs stringForColumn:@"id"];
//        NSString *cid = [rs stringForColumn:@"car_id"];
//        NSString *brand = [rs stringForColumn:@"brand"];
//        NSString *model = [rs stringForColumn:@"model"];
//        NSString *detail = [rs stringForColumn:@"detail"];
//        NSString *sub_model = [rs stringForColumn:@"sub_model"];
//        NSString *price = [rs stringForColumn:@"price"];
//        NSString *thumb = [rs stringForColumn:@"thumb"];
//        
//        
//        NSLog(@"id %@ carid %@ brand %@ model %@ detail %@ sub_model %@ price %@ thumb %@",sid,cid,brand,model,detail,sub_model,price,thumb);
        
    }
    NSLog(@"%d",arrFavcar.count);
    
    [rs close];
    [database close];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrFavcar count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"%@",arrFavcar[indexPath.row]);
    cellFavoriteCar *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    if (cell ==nil) {
        cell = [[cellFavoriteCar alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSLog(@"%@",arrFavcar [indexPath.row]);
    
    if([arrFavcar [indexPath.row] objectForKey:@"id"] != [NSNull null])
    {
        
    
    NSURL *thmbUrl = [NSURL URLWithString:[arrFavcar [indexPath.row] objectForKey:@"thumb"]];;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadWithURL:thmbUrl
                     options:0
                    progress:nil
     
                   completed:^(UIImage *image, NSError *error, SDImageCacheType  SDImageCacheTypeMemory, BOOL finished)
     {
         if (image)
         {
             cell.imgFavCar .image = image;
         }
         else
         {
             
             cell.imgFavCar.image = [UIImage imageNamed:@"logo.png"];
         }
         
         [UIApplication sharedApplication].networkActivityIndicatorVisible =NO ;
         
     }];
    
    
    
    NSString *brand = [NSString stringWithFormat:@"%@ %@",[arrFavcar [indexPath.row] objectForKey:@"brand"],[arrFavcar [indexPath.row] objectForKey:@"model"]];
    
    NSString *detail= [NSString stringWithFormat:@"%@ %@",[arrFavcar [indexPath.row] objectForKey:@"sub_model"],[arrFavcar [indexPath.row] objectForKey:@"detail"]];
    
    id strP = [arrFavcar [indexPath.row] objectForKey:@"price"];
        
    NSString *price = [strP stringValue];
        
        
       
    
    [cell.lblFavCarBrand setText:brand];
    [cell.lblFavCarModel setText:detail];
    [cell.lblFavCarPrice setText:price];
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
