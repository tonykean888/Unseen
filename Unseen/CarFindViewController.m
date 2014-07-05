//
//  CarFindViewController.m
//  Unseen
//
//  Created by Tony on 6/25/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarFindViewController.h"


@interface CarFindViewController ()<CarTypeViewControllerDelegate,CarBrandViewControllerDelegate,CarModelViewControllerDelegate>


@end

@implementation CarFindViewController
{
    NSString *cartype,*cartypeID,*brandID,*brandName,*modelName,*modelID;
}

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
    return 4;
}



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rows in section 0 should not be selectable
    if ( indexPath.section == 0 ) return indexPath;
    
    // first 3 rows in any section should not be selectable
    if ( indexPath.row <= 2 ) return nil;
    
    // By default, allow row to be selected
    return indexPath;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
   
    
    return cell;
}
*/

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
#pragma mark - CarTypeDelegate

-(void)cartypeViewCOntroller:(NSString *)selectedCarType forCarTypeID:(NSString *)selectedCarTypeID
{
    cartype = selectedCarType;
    cartypeID = selectedCarTypeID;
    self.lblSelCarType.text = cartype;
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - CarBrandDelegate

-(void)carbrandViewController:(NSString *)selectedCarBrand forCarBrandID:(NSString *)selectedCarBrandID;
{
    brandID = selectedCarBrandID;
    brandName = selectedCarBrand;
    self.lblSelCarBrand.text = brandName;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CarModelDelegate
-(void)carModelViewControllers:(NSString *)selectedCarModel forCarModelID:(NSString *)selectedCarModelID;
{
    modelID = selectedCarModelID;
    modelName = selectedCarModel;
    self.lblSelCarModel.text = modelName;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushSelCarType"])
    {
        [[segue destinationViewController] setSelectedCarType:cartype];
        [[segue destinationViewController] setSelectedCarTypeID:cartypeID];
        [[segue destinationViewController] setDelegate:self];
        
        
    }
    
    if ([[segue identifier] isEqualToString:@"pushSelCarBrand"])
    {
        
        [[segue destinationViewController] setSelCarTypeID:cartypeID];
        [[segue destinationViewController] setSelectedCarBrand:brandName];
        [[segue destinationViewController] setSelectedCarBrandID:brandID];
        [[segue destinationViewController] setDelegate:self];
    } 
    
    if ([[segue identifier] isEqualToString:@"pushSelCarModel"])
    {
        
        [[segue destinationViewController] setSelCarTypeID:cartypeID];
        [[segue destinationViewController] setSelCarBrand:brandName];
        [[segue destinationViewController] setSelCarBrandID:brandID];
        [[segue destinationViewController] setSelectedCarModel:modelName];
        [[segue destinationViewController] setDelegate:self];
    }
    
    if ([[segue identifier] isEqualToString:@"pushFindResult"])
    {
        [[segue destinationViewController] setTypeID:cartypeID];
        [[segue destinationViewController] setBrandID:brandID];
        [[segue destinationViewController] setBrandName:brandName];
        [[segue destinationViewController] setModelID:modelID];
       
    }
    
    
    
}
- (IBAction)btnFindCar:(id)sender {
 
    
   

       NSLog(@"selectedID: %@ selectTypeName %@  brandID %@ brandName%@ modelId %@ modelName %@",cartypeID,cartype,brandID,brandName,modelID,modelName);
 
    

    
   
}
@end
