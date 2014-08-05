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
  
    NSMutableArray *carData;
    NSString *selectCarID;
   
    FavoriteDataAccess *db;
}
@end

@implementation FavoriteViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        db = [[FavoriteDataAccess alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
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

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    db = [[FavoriteDataAccess alloc] init];
    
   carData = [NSMutableArray arrayWithArray:[db findCarData]];
    [self.tableView reloadData];
    NSLog(@"%@",carData);
    
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
    return [carData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"%@",arrFavcar[indexPath.row]);
    cellFavoriteCar *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    if (cell ==nil) {
        cell = [[cellFavoriteCar alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Car *car = [carData objectAtIndex:indexPath.row];
    
    
    //NSLog(@"%@",car.carid);
    
   if(car.carid != NULL)
    {
        
    
    NSURL *thmbUrl = [NSURL URLWithString:car.image];;
    
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
    
       
        NSString *brand = [NSString stringWithFormat:@"%@ %@",car.brand,car.model];
        NSString *detail= [NSString stringWithFormat:@"%@ %@",car.subModel,car.detail];
        NSString *price = car.prices;
  
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




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"ลบข้อมูลรถ";
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Car * car = [carData objectAtIndex:indexPath.row];
        [db deleteFavoriteCarWithID:car.carid];
        [carData removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}


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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushToDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
          Car *car = [carData objectAtIndex:indexPath.row];

        [[segue destinationViewController] setSCarID:car.carid];
        
        
        
    }
}




@end
