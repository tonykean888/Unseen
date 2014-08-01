//
//  SubSubModelViewController.m
//  Unseen
//
//  Created by Tony on 7/26/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "SubSubModelViewController.h"

@interface SubSubModelViewController () <FindResultDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation SubSubModelViewController

@synthesize listSubModel,selectSubSubModel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    FindResultViewController *obj = [[FindResultViewController alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    

   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"ยกเลิก" style:UIBarButtonItemStylePlain target:self action:@selector(btnCancelPick:)];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"เลือกสำเร็จ" style:UIBarButtonItemStylePlain target:self action: @selector(btnPickSubModel:)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FindResultDelegate
-(void)listSubSubmodel:(NSArray *)arrSubSubModel
{
    
    self.listSubModel = arrSubSubModel;
    
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
    
    NSLog(@"%d",listSubModel.count);
    
    return [listSubModel count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellid = @"cell";
    cellSubSubModel *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[cellSubSubModel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    
    [cell.lblSubSubModel setText:[listSubModel objectAtIndex:indexPath.row]];
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectSubSubModel=[listSubModel objectAtIndex:indexPath.row];
    //NSLog(@"%d : %@",indexPath.row,[listSubModel objectAtIndex:indexPath.row]);

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
*//*// Override to support conditional rearranging of the table view.
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


- (IBAction)btnCancelPick:(id)sender{
   //[self.delegate subSubModelViewControllerDidCancel:self];
    [self.delegate subSubModelViewControllerDidCancel:self];
}

- (IBAction)btnPickSubModel:(id)sender {
    [self.delegate subSubModelViewController:self didPicksubSubModel:selectSubSubModel];
}

@end
