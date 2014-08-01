//
//  FindResultViewController.m
//  Unseen
//
//  Created by Tony on 6/30/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "FindResultViewController.h"


@interface FindResultViewController ()<SubSubModelDelegate,WYPopoverControllerDelegate,UISearchDisplayDelegate,UISearchBarDelegate>
{
    WYPopoverController *subSubModelPopover;
    
    
    NSMutableArray *arrSubSubModel,*dataCarCell;
    NSInteger selectedIndex;
    NSString *selectedCarID,*pickSubSubModel;
    NSMutableDictionary *dict;
    NSDictionary *dataCar;
    NSArray *filterArrResult;
}

@end

@implementation FindResultViewController

@synthesize typeID,brandName,modelID,brandID,selectCarID,subModelID,tableItems,cachedImages,sidebarButton,arrSmodel,arrResult,searchResult;

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
    arrSubSubModel = [[NSMutableArray alloc]init];
    searchResult = [[NSMutableArray alloc] init];
    
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
                ,nil];
        
        NSLog(@"%@",strDetail);
        
        if([arrSubSubModel containsObject:strDetail]==false && ![strDetail isEqualToString: @"0"] )
        {
            
            [arrSubSubModel addObject:strDetail];
            
        }
        
        [arrResult addObject:dict];
        
    }
    
    
    arrSmodel = [arrSubSubModel sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSLog(@"%@",arrSmodel);
    
    self.searchResult = [NSMutableArray arrayWithCapacity:[self.arrResult count]];
    [self.tableView reloadData];
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


#pragma mark - searchDisplay Delegate
//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    if (self) {
//
//    }
//}

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    [searchResult removeAllObjects];
    NSString *strPredicted = searchText;
    NSString *key = @"detail";
    NSPredicate *p = [NSPredicate predicateWithFormat:@"%K LIKE[cd] %@",key,strPredicted];
    searchResult = [NSMutableArray arrayWithArray:[arrResult filteredArrayUsingPredicate:p]];
    NSLog(@"%@",searchResult);
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView){
        NSLog(@"%d",[searchResult count]);
        return [searchResult count];
    } else {
         NSLog(@"%d",[arrResult count]);
        return [arrResult count];
    }
    
 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    cellFindResult *cell = (cellFindResult*)[self.tableView dequeueReusableCellWithIdentifier:@"cellResult"];
    if(cell == nil)
    {
        cell = [[cellFindResult alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellResult"];
     
    }
    

    
    if (tableView == self.searchDisplayController.searchResultsTableView){
        dataCarCell = searchResult;
    } else {
        dataCarCell = arrResult;
    }
    

   
    
   NSURL *thmbUrl = [NSURL URLWithString:[dataCarCell [indexPath.row] objectForKey:@"thumb"]];;
    
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
         
          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO ;
        
     }];
   
    
   
   NSString *brand = [NSString stringWithFormat:@"%@ %@",[dataCarCell [indexPath.row] objectForKey:@"brand"],[dataCarCell [indexPath.row] objectForKey:@"model"]];
    
    NSString *detail= [NSString stringWithFormat:@"%@ %@",[dataCarCell [indexPath.row] objectForKey:@"subModel"],[dataCarCell [indexPath.row] objectForKey:@"detail"]];
    
    NSString *strP = [dataCarCell [indexPath.row] objectForKey:@"prices"];
    

    
    
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
    cell.lblPrices.text =strP;

   
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
#pragma mark - WYPopoverControllDelegate

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)aPopoverController
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)aPopoverController
{
    if (aPopoverController == subSubModelPopover)
    {
        UINavigationController *navigationController = (UINavigationController *)aPopoverController.contentViewController;
        
        SubSubModelViewController *subSubmodelViewController = [[navigationController viewControllers] objectAtIndex:0];
        subSubmodelViewController.delegate = nil;
        subSubModelPopover.delegate = nil;
        subSubModelPopover = nil;
                                                        
                                                        
    }

}




#pragma mark - SubSubModelDelegate

-(void)subSubModelViewControllerDidCancel:(SubSubModelViewController *)controller
{
    controller.delegate = nil;
    [subSubModelPopover dismissPopoverAnimated:YES];
    subSubModelPopover.delegate = nil;
    subSubModelPopover = nil;
    
}



-(void)subSubModelViewController:(SubSubModelViewController *)controller didPicksubSubModel:(NSString *)subSubModelName;
{
    
    pickSubSubModel = subSubModelName;
    //[self filteredArrayUsingredicate:arrResult strforpredict:pickSubSubModel];
  //  [self filterContentForSearchText:pickSubSubModel scope:nil];
    
    controller.delegate = nil;
    [subSubModelPopover dismissPopoverAnimated:YES];
    subSubModelPopover.delegate = nil;
    subSubModelPopover = nil;
   
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushDetail"])
    {
        NSIndexPath *indexP = [self.tableView indexPathForSelectedRow];
     
        NSDictionary *tmpArr = [dataCarCell objectAtIndex:indexP.row];
        selectCarID = [tmpArr objectForKey:@"carID"];
        NSLog(@"%@",selectCarID);
        [[segue destinationViewController] setSCarID:selectCarID];
        
   
 
    }
    if ([[segue identifier] isEqualToString:@"popSubSubModel"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        
        SubSubModelViewController *subSubModelViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        [subSubModelViewController setContentSizeForViewInPopover:CGSizeMake(280, 280)];
        
        //[subSubModelViewController setDelegate:self];
        //[self.delegate listSubSubmodel:arrSmodel];
        
        [subSubModelViewController setListSubModel:arrSmodel];
        [subSubModelViewController setDelegate:self];
      
        
        WYStoryboardPopoverSegue *popoverSeque = (WYStoryboardPopoverSegue *)segue;
        
        subSubModelPopover = [popoverSeque popoverControllerWithSender:sender permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
        subSubModelPopover.popoverLayoutMargins = UIEdgeInsetsMake(4, 4, 4, 4);
        [subSubModelPopover setDelegate:self];
        
        
    }
 
}


@end
