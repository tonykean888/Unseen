//
//  CarDetailViewController.m
//  Unseen
//
//  Created by Tony on 7/1/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarDetailViewController.h"

@interface CarDetailViewController ()
{
    NSMutableDictionary *dict;
    NSString *carDetail,*tentDetail;
    NSMutableArray *arrDetail;
    
}
@end

@implementation CarDetailViewController

@synthesize segmentControl,imageView,textViewDetail,sCarID,tentScrollView,carScrollView,mapImage,tentDetailText;

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
    
    NSLog(@"%@",sCarID);
    
    arrDetail = [[NSMutableArray alloc]init];
    
    NSString *strUrl = [NSString stringWithFormat:@"http://localhost/unseen/CarDetail.php?carID=%@",sCarID];
    NSLog(@"url %@",strUrl);
    
    NSString *sTentID = [sCarID substringWithRange:NSMakeRange(0, 5)];
    
    NSString *strUrlMap = [NSString stringWithFormat:@"http://www.unseencar.com/tent/%@Lmap.jpg",sTentID];
    
    NSLog(@"url %@",strUrlMap);
    
    NSData *jsonResult = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonResult options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObj)
    {
        NSString *strCarID = [dataDict objectForKey:@"car_id"];
        NSString *strBrand = [dataDict objectForKey:@"brand_name"];
        NSString *strModel = [dataDict objectForKey:@"model"];
        NSString *strDetail = [dataDict objectForKey:@"sub_detail"];
        NSString *strSubModel = [dataDict objectForKey:@"sub_submodel"];
        NSString *strPrices = [dataDict objectForKey:@"prices"];
        NSString *strPricesDown = [dataDict objectForKey:@"free_down"];
        NSString *strCarInt = [dataDict objectForKey:@"car_interior"];
        NSString *strCarExt = [dataDict objectForKey:@"car_exterior"];
        
        NSString *strTentName = [dataDict objectForKey:@"name"];
        NSString *strTentAddr = [dataDict objectForKey:@"address"];
        NSString *strTentTel = [dataDict objectForKey:@"tel_office"];
        
    
        NSString *folder = [[dataDict objectForKey:@"car_id"] substringWithRange:NSMakeRange(5, 2)];
        NSString *thumbName = [strCarID stringByAppendingString:@"1.jpg"];
        
        
        NSString *strThumbURL = [NSString stringWithFormat:@"http://www.unseencar.com/carpic/%@/S/%@",folder,thumbName];
    
        dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
            strCarID,@"carID",
            strBrand,@"brand",
            strModel,@"model",
            strDetail,@"detail",
            strSubModel,@"subModel",
            strPrices,@"prices",
            strPricesDown,@"priceDown",
            strCarExt,@"carExt",
            strCarInt,@"carInt",
            strThumbURL,@"thumb",
            strTentName,@"tentName",
            strTentAddr,@"tentAddr",
            strTentTel,@"tentTel"
            , nil];
    
        [arrDetail addObject:dict];
    
        
   
    }
    
    
    
    NSURL *thmbUrl = [NSURL URLWithString:[arrDetail [0] objectForKey:@"thumb"]];
    
    NSData *thmbData = [NSData dataWithContentsOfURL:thmbUrl];
    UIImage *thumb = [UIImage imageWithData:thmbData];
    
    NSURL *thmbMap = [NSURL URLWithString:strUrlMap];
    
    NSData *thmbMapData = [NSData dataWithContentsOfURL:thmbMap];
    UIImage *map = [UIImage imageWithData:thmbMapData];
    
    
    
    carDetail = [NSString stringWithFormat:@"%@ %@ %@ %@ \rราคา : %@ บาท\rดาวน์ %@\r\rอุปกรณ์เสริมภายใน \r%@ \r\rอุปกรณ์เสริมภายนอก\r%@ \r" ,
                            [arrDetail [0] objectForKey:@"brand"],
                            [arrDetail [0] objectForKey:@"model"],
                            [arrDetail [0] objectForKey:@"subModel"],
                            [arrDetail [0] objectForKey:@"detail"],
                            [arrDetail [0] objectForKey:@"prices"],
                            [arrDetail [0] objectForKey:@"priceDown"],
                           // [arrDetail [0] objectForKey:@"carID"]];
                            [arrDetail [0] objectForKey:@"carInt"],
                            [arrDetail [0] objectForKey:@"carExt"]];
    
    tentDetail = [NSString stringWithFormat:@"ชื่อเต็นท์ : %@ \rที่อยู่ :%@ \rเบอร์โทรศัพท์ :%@ \r ",
                            [arrDetail [0] objectForKey:@"tentName"],
                            [arrDetail [0] objectForKey:@"tentAddr"],
                            [arrDetail [0] objectForKey:@"tentTel"]];
    
    
    [self.imageView setImage:thumb];
    [self.segmentControl setSelectedSegmentIndex:0];
    [textViewDetail setText:carDetail];
    [mapImage setImage:map];
    
    
    [self.carScrollView setHidden:NO];
    [self.tentScrollView setHidden:YES];
    [self.mapImage setHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)onChangeSeg:(id)sender {
    

    
    switch ([segmentControl selectedSegmentIndex]) {
        case 0:
            [carScrollView setHidden:NO];
            [tentScrollView setHidden:YES];
            [mapImage setHidden:YES];
            [textViewDetail setText:carDetail];
            
            
            break;
        case 1:
            
            [carScrollView setHidden:YES];
            [tentScrollView setHidden:NO];
            [mapImage setHidden:NO];
            [tentDetailText setText:tentDetail];
             break;
            
        default:
            break;
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushCarGallery"])
    {
        
        
        NSString *carid = [arrDetail[0] objectForKey:@"carID"];
        
        NSLog(@"%@",carid);
        
        [[segue destinationViewController] setSCarID:carid];
        
        
        
    }
}


@end
