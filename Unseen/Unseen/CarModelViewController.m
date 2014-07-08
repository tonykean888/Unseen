//
//  CarModelViewController.m
//  Unseen
//
//  Created by Tony on 6/28/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarModelViewController.h"

@interface CarModelViewController ()

@end

@implementation CarModelViewController
{
    NSMutableArray *arrCarModel;
    NSInteger selectedIndex;
    NSString *carTypeName,*modelName,*modelID;
    NSMutableDictionary *dict;
}

@synthesize selCarTypeID,selCarBrand,selCarBrandID,selectedCarModel,selectedCarModelID;

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
    
    arrCarModel = [[NSMutableArray alloc] init];
    selCarBrand = [selCarBrand stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/unseen/CarModeljson.php?typeID=%@&brandName=%@",selCarTypeID,selCarBrand];
    
    
    NSLog(@"url %@",strURL);
    
    
    NSData *jsonBrand = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonBrand options:NSJSONReadingMutableContainers error:nil];
    for(NSDictionary *dataDict in jsonObj)
    {
        NSString *strCarModel = [dataDict objectForKey:@"MODEL"];
        NSString *strCarModelID = [dataDict objectForKey:@"ID"];
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                strCarModel,@"model",
                strCarModelID,@"modelID",
                nil];
        [arrCarModel addObject:dict];
    }
    //NSLog(@"typeID %@",_selCarTypeID);
    
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"ทุกรุ่น",@"model",
                                  @"0",@"modelID",
                                  nil];
    
    [arrCarModel insertObject:dict2 atIndex:0];
    
    // NSLog(@"url %@",strURL);
    // NSLog(@"brandID %@",selectedCarBrandID);
    
    NSMutableArray *valueArr = [arrCarModel valueForKey:@"model"];
    int index = [valueArr indexOfObject:selectedCarModel];
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
    return [arrCarModel count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [arrCarModel [indexPath.row] objectForKey:@"model"];
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
    modelID = [arrCarModel[indexPath.row] objectForKey:@"modelID"];
    modelName = [arrCarModel[indexPath.row] objectForKey:@"model"];
    [self.delegate carModelViewControllers:modelName forCarModelID:modelID];
    
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
