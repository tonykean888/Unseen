//
//  CarUpdateController.m
//  Unseen
//
//  Created by Tony on 7/2/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarUpdateController.h"

@interface CarUpdateController ()
{
    NSMutableArray *arrCarUpadate;
    NSMutableDictionary *dict;
    NSString *selectCarID;
    
}
@end

@implementation CarUpdateController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrCarUpadate = [[NSMutableArray alloc]init];
    NSString *strUrl = [NSString stringWithFormat:@"http://localhost/unseen/CarUpdateJson.php"];
    NSData *jsonResult = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonResult options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObj)
    {
        NSString *strCarID = [dataDict objectForKey:@"car_id"];

        NSString *folder = [[dataDict objectForKey:@"car_id"] substringWithRange:NSMakeRange(5, 2)];
        
        NSString *thumbName = [strCarID stringByAppendingString:@"1.jpg"];
        
        NSString *strThumbURL = [NSString stringWithFormat:@"http://www.unseencar.com/carpic/%@/S/%@",folder,thumbName];
        NSString *strModel = [dataDict objectForKey:@"model"];
        NSString *strPrice = [dataDict objectForKey:@"prices"];
        
        NSString *strYear;
        
      
        if([[dataDict objectForKey:@"years"] length] == 4 )
        {
          strYear = [[dataDict objectForKey:@"years"] substringWithRange:NSMakeRange(2, 2)];
        }
        
        NSLog(@"%@",strYear);
        
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                strCarID,@"carID",
                strThumbURL,@"thumb",
                strModel,@"carModel",
                strYear,@"carYear",
                strPrice,@"carPrice"
                , nil];
        [arrCarUpadate addObject:dict];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrCarUpadate count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    UIImageView *carUpdateThumb = (UIImageView *)[cell viewWithTag:100];
//    
    NSURL *thmbUrl = [NSURL URLWithString:[arrCarUpadate [indexPath.row] objectForKey:@"thumb"]];
    NSData *thmbData = [NSData dataWithContentsOfURL:thmbUrl];
    UIImage *thumb = [UIImage imageWithData:thmbData];
//    
//    
//    carUpdateThumb.image = [UIImage imageWithData:thmbData];
    
    cellCarUpdate *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
   
    [[cell imageThumb] setImage:thumb];
    
    [[cell lblPrices] setText:[arrCarUpadate [indexPath.row] objectForKey:@"carPrice"]];
  
    NSString *sModel = [arrCarUpadate [indexPath.row] objectForKey:@"carModel"];
    NSString *syear = [arrCarUpadate [indexPath.row] objectForKey:@"carYear"];
    NSString *sModelYear = [NSString stringWithFormat:@"%@ '%@",sModel,syear];
    
    
    [[cell lblModel] setText:sModelYear];
   // [[cell lblModel] setNumberOfLines:0];
   // [[cell lblModel] setFrame:CGRectMake(10, 80, 100, 20)];
    //[[cell lblModel] setBackgroundColor:[UIColor redColor]];
   // [[cell lblModel]setTextAlignment:NSTextAlignmentCenter];
    
    //[[cell lblModel] sizeToFit];
    
    
    
    return cell;
    
    
    
}



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
        NSArray *indexPs = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexP = [indexPs objectAtIndex:0];
        
        NSDictionary *tmpArr = [arrCarUpadate objectAtIndex:indexP.row];
                                
        selectCarID = [tmpArr objectForKey:@"carID"];
        NSLog(@"%@",selectCarID);
        [[segue destinationViewController] setSCarID:selectCarID];
        
        
        
    }
}


@end
