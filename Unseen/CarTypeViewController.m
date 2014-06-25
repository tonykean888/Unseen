//
//  CarTypeViewController.m
//  Unseen
//
//  Created by Tony on 6/25/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarTypeViewController.h"

@interface CarTypeViewController ()

@end

@implementation CarTypeViewController
{
    NSMutableArray *arrCarType;
    NSInteger selectedIndex;
    NSString *carTypeID,*carTypeName;
    NSMutableDictionary *dict;
}
@synthesize selectedCarTypeID,selectedCarType;

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
    carTypeID = @"id";
    carTypeName = @"car_type_th";
    arrCarType = [[NSMutableArray alloc] init];
    
    NSData *jsonCarType = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://localhost/unseen/CarTypeJson.php"]];
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonCarType options:NSJSONReadingMutableContainers error:nil];
    for(NSDictionary *dataDict in jsonObj)
    {
        NSString *strCarTypeID = [dataDict objectForKey:@"id"];
        NSString *strCarTypeName = [dataDict objectForKey:@"car_type_th"];
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                strCarTypeID,@"typeID",
                strCarTypeName,@"CarType"
                ,nil];
       // NSLog(@"id:%@,type:%@",strCarTypeID,strCarTypeName);
        [arrCarType addObject:dict];
        
        
        //selectedIndex = [arrCarType indexOfObject:self.carType];
    }
    NSMutableArray *valueArr = [arrCarType valueForKey:@"CarType"];
    int index = [valueArr indexOfObject:selectedCarType];
    //NSLog(@"at row %d",index);
    selectedIndex = index;
    
//    NSUInteger index;
//    NSString *myIdentifier = selectedCarType;
//    
//    index = [arrCarType indexOfObjectPassingTest:
//             ^(id obj, NSUInteger idx, BOOL *stop) {
//                 return ([obj.identifier isEqualToString:myIdentifier]);
//             }];
    
   // NSLog(@"%@:", [arrCarType[3] objectForKey:@"CarType"]);
   //  NSLog(@"count:%lu",(unsigned long)[arrCarType count]);
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
    return [arrCarType count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   //NSLog(@"แถวที่ : %d",indexPath.row);
    
    cell.textLabel.text = [arrCarType[indexPath.row] objectForKey:@"CarType"];
    
    if (indexPath.row == selectedIndex)
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    carTypeID = [arrCarType[indexPath.row] objectForKey:@"ID"];
    carTypeName = [arrCarType[indexPath.row] objectForKey:@"CarType"];
    [self.delegate cartypeViewCOntroller:carTypeName forCarTypeID:carTypeID];
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
