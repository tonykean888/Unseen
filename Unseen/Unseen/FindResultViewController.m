//
//  FindResultViewController.m
//  Unseen
//
//  Created by Tony on 6/30/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "FindResultViewController.h"


@interface FindResultViewController ()
{
    NSMutableArray *arrResult;
    NSInteger selectedIndex;
    NSString *selectedCarID;
    NSMutableDictionary *dict;
    NSDictionary *dataCar;

}
@end

@implementation FindResultViewController

@synthesize typeID,brandName,modelID,brandID,selectCarID,subModelID,tableItems,cachedImages;

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
    
    brandName = [brandName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    arrResult = [[NSMutableArray alloc]init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES ;
    
    NSString *strUrl = [NSString stringWithFormat:@"http://localhost/unseen/FindResult.php?typeID=%@&brandID=%@&brandName=%@&modelID=%@&subModelID=%@",typeID,brandID,brandName,modelID,subModelID];
    
    
    
    NSLog(@"brand %@ ",brandName);
    NSLog(@"model %@ ",modelID );
    NSLog(@"type %@ ",typeID);
    NSLog(@"url %@",strUrl);
    
    
    
 //code เดิมก่อนทดลองใช้ afnetwork
    NSData *jsonResult = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonResult options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dataDict in jsonObj)
    {
        NSString *strCarID = [dataDict objectForKey:@"car_id"];
        NSString *strBrand = [dataDict objectForKey:@"brand_name"];
        NSString *strModel = [dataDict objectForKey:@"model"];
        NSString *strDetail = [dataDict objectForKey:@"detail"];
        NSString *strSubModel = [dataDict objectForKey:@"sub_submodel"];
        NSString *strPrices = [dataDict objectForKey:@"prices"];
       
        NSString *strThumbURL = [dataDict objectForKey:@"thumb"];
        
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                strCarID,@"carID",
                strBrand,@"brand",
                strModel,@"model",
                strDetail,@"detail",
                strSubModel,@"subModel",
                strPrices,@"prices",
                strThumbURL,@"thumb"
                , nil];
        
        [arrResult addObject:dict];
    }
    
    
 

    
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


    return [arrResult count];


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellFindResult *cell = [tableView dequeueReusableCellWithIdentifier:@"cellResult" forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[cellFindResult alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellResult"];
     
    }
    
   NSURL *thmbUrl = [NSURL URLWithString:[arrResult [indexPath.row] objectForKey:@"thumb"]];;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadWithURL:thmbUrl
                     options:0
                    progress:nil
     
                   completed:^(UIImage *image, NSError *error, SDImageCacheType  SDImageCacheTypeMemory, BOOL finished)
     {
         if (image)
         {
             cell.cellThumb.image = image;
         }
         else
         {
             
             cell.cellThumb.image = [UIImage imageNamed:@"logo.png"];
         }
         
          [UIApplication sharedApplication].networkActivityIndicatorVisible =NO ;
        
     }];
   
    
   
    NSString *brand = [NSString stringWithFormat:@"%@ %@",[arrResult [indexPath.row] objectForKey:@"brand"],[arrResult [indexPath.row] objectForKey:@"model"]];
    
    NSString *detail= [NSString stringWithFormat:@"%@ %@",[arrResult [indexPath.row] objectForKey:@"subModel"],[arrResult [indexPath.row] objectForKey:@"detail"]];
    
    NSString *strP = [arrResult [indexPath.row] objectForKey:@"prices"];
    

    
    
//    NSNumberFormatter *formatPrice =[[NSNumberFormatter alloc]init];
//  
//    [formatPrice setNumberStyle:NSNumberFormatterDecimalStyle];
//    NSString *formatted = [formatPrice stringFromNumber:[NSNumber numberWithInteger:*strP];
//
//    
//    NSString *prices = [NSString stringWithFormat:@"ราคา %d บาท",formatted];
    
    
    //cell.cellThumb.image = thumb;

    cell.lblBrand.text = brand;
    
    cell.lblDetail.text= detail;
    
    cell.lblPrices.text = strP;
   
   

   
    return cell;
}

//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    carID = [arrResult[indexPath.row] objectForKey:@"carID"];
//   
//    [self.delegate findResultController:carID];
//}


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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushDetail"])
    {
        NSIndexPath *indexP = [self.tableView indexPathForSelectedRow];
     
        NSDictionary *tmpArr = [arrResult objectAtIndex:indexP.row];
        selectCarID = [tmpArr objectForKey:@"carID"];
        NSLog(@"%@",selectCarID);
        [[segue destinationViewController] setSCarID:selectCarID];
        
   
 
    }
}


@end
