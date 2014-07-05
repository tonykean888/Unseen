//
//  CarBrandViewController.m
//  Unseen
//
//  Created by Tony on 6/26/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarBrandViewController.h"


@interface CarBrandViewController ()

@end

@implementation CarBrandViewController
{
    NSMutableArray *arrCarBrand;
    NSInteger selectedIndex;
    NSString *brandID,*brandName;
    NSMutableDictionary *dict;
    
}
@synthesize selectedCarBrand,selectedCarBrandID,selCarTypeID;

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
    
    arrCarBrand = [[NSMutableArray alloc] init];
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/unseen/CarBrandJson.php?carTypeID=%@",selCarTypeID];
    
    NSLog(@"url %@",strURL);
    NSData *jsonBrand = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonBrand options:NSJSONReadingMutableContainers error:nil];
    int i = 1;
    for(NSDictionary *dataDict in jsonObj)
    {
        NSString *strCarBrand = [dataDict objectForKey:@"brand_name"];
        NSString *strCarBrandID = [NSString stringWithFormat:@"%d",i];
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                strCarBrand,@"brandName",
                 strCarBrandID,@"brandID",
                nil];
        [arrCarBrand addObject:dict];
        i++;
    }
    //NSLog(@"typeID %@",_selCarTypeID);

    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
            @"ทุกยี่ห้อ",@"brandName",
            @"0",@"brandID",
            nil];
    
    [arrCarBrand insertObject:dict2 atIndex:0];
    
   // NSLog(@"url %@",strURL);
   // NSLog(@"brandID %@",selectedCarBrandID);
    
    NSMutableArray *valueArr = [arrCarBrand valueForKey:@"brandName"];
    int index = [valueArr indexOfObject:selectedCarBrand];
    selectedIndex = index;
    
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
    return [arrCarBrand count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = [arrCarBrand [indexPath.row] objectForKey:@"brandName"];
    if(indexPath.row ==selectedIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(selectedIndex != NSNotFound)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    selectedIndex = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    brandID = [arrCarBrand[indexPath.row] objectForKey:@"brandID"];
    brandName = [arrCarBrand[indexPath.row] objectForKey:@"brandName"];
    [self.delegate carbrandViewController:brandName forCarBrandID:brandID];

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
