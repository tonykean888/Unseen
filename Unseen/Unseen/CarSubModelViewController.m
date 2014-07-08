//
//  CarSubModelViewController.m
//  Unseen
//
//  Created by Tony on 7/8/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarSubModelViewController.h"

@interface CarSubModelViewController ()
{
    NSMutableArray *arrCarSubModel;
    NSInteger selectedIndex;
    NSString *subModelName,*subModelID;
    NSMutableDictionary *dict;
}

@end


@implementation CarSubModelViewController
@synthesize selectedCarSubModelID,selectedCarSubModel,selCarModelID;

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
    arrCarSubModel = [[NSMutableArray alloc]init];
    
    NSString *strUrl = [NSString stringWithFormat:@"http://localhost/unseen/CarSubModel.php?modelID=%@",selCarModelID];
    
    NSLog(@"url %@",strUrl);
    NSData *jsonSubModel = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonSubModel options:NSJSONReadingMutableContainers error:nil];

    for (NSDictionary *dataDict in jsonObj)
    {
        NSString *strCarSubModelID = [dataDict objectForKey:@"ID"];
        NSString *strCarSubModel = [dataDict objectForKey:@"SUBMODEL"];
        
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                strCarSubModelID,@"subModelID",
                strCarSubModel,@"subModel",
                nil];
        
        [arrCarSubModel addObject:dict];
        
       
    }
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"ทุกรุ่นโฉม",@"subModel",
                                  @"0",@"subModelID",
                                  nil];
    
    [arrCarSubModel insertObject:dict2 atIndex:0];
    
    
    NSMutableArray *valueArr = [arrCarSubModel valueForKey:@"subModel"];
    int index = [valueArr indexOfObject:selectedCarSubModel];
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
    return [arrCarSubModel count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [arrCarSubModel [indexPath.row] objectForKey:@"subModel"];
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
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];

    }
    selectedIndex = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    subModelID = [arrCarSubModel [indexPath.row] objectForKey:@"subModelID"];
    subModelName = [arrCarSubModel [indexPath.row] objectForKey:@"subModel"];
    [self.delegate CarSubModelViewController:subModelName forCarSubModelID:subModelID];
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

@end
