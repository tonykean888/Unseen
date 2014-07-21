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
    NSURL *thmbUrl,*thmbMap,*gallery1,*gallery2,*gallery3,*gallery4,
           *gallery5,*gallery6,*gallery7,*gallery8,*gallery9;

}
@end

@implementation CarDetailViewController

@synthesize segmentControl,imageView,textViewDetail,sCarID,tentScrollView,carScrollView,mapImage,tentDetailText,btnImage,btnMapImage;
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

    
    //    Reachability *reach = [Reachability reachabilityWithHostName:strUrl];
    //    NetworkStatus status = [reach currentReachabilityStatus];
    //    NSLog(@"status : %d",status);
    //    if (status == NotReachable) {
    //        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"ต้องการ การเชื่อมต่อ Internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //    }
    //    
    NSLog(@"%@",sCarID);
  
    arrDetail = [[NSMutableArray alloc]init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES ;
    
    NSString *strUrl = [NSString stringWithFormat:@"http://localhost/unseen/CarDetail.php?carID=%@",sCarID];
    
    NSLog(@"url %@",strUrl);
    
    
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
        NSString *strThumbURL = [dataDict objectForKey:@"thumb"];
        NSString *strMap = [dataDict objectForKey:@"map"];
        NSString *strGallery1 = [dataDict objectForKey:@"gallery1"];
        NSString *strGallery2 = [dataDict objectForKey:@"gallery2"];
        NSString *strGallery3 = [dataDict objectForKey:@"gallery3"];
        NSString *strGallery4 = [dataDict objectForKey:@"gallery4"];
        NSString *strGallery5 = [dataDict objectForKey:@"gallery5"];
        NSString *strGallery6 = [dataDict objectForKey:@"gallery6"];
        NSString *strGallery7 = [dataDict objectForKey:@"gallery7"];
        NSString *strGallery8 = [dataDict objectForKey:@"gallery8"];
        NSString *strGallery9 = [dataDict objectForKey:@"gallery9"];
        
    
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
            strTentTel,@"tentTel",
            strMap,@"map",
            strGallery1,@"gallery1",
            strGallery2,@"gallery2",
            strGallery3,@"gallery3",
            strGallery4,@"gallery4",
            strGallery5,@"gallery5",
            strGallery6,@"gallery6",
            strGallery7,@"gallery7",
            strGallery8,@"gallery8",
            strGallery9,@"gallery9"
            , nil];
    
        [arrDetail addObject:dict];
     
   
    }
    
 
    thmbUrl = [NSURL URLWithString:[arrDetail [0] objectForKey:@"thumb"]];
    thmbMap = [NSURL URLWithString:[arrDetail [0] objectForKey:@"map"]];
    gallery1 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery1"]];
    gallery2 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery2"]];
    gallery3 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery3"]];
    gallery4 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery4"]];
    gallery5 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery5"]];
    gallery6 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery6"]];
    gallery7 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery7"]];
    gallery8 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery8"]];
    gallery9 = [NSURL URLWithString:[arrDetail [0] objectForKey:@"gallery9"]];
    
    NSData *thmbMapData = [NSData dataWithContentsOfURL:thmbMap];
    UIImage *map = [UIImage imageWithData:thmbMapData];
    
 
    
//    [btnViewImage setImageWithURL:thmbUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logo.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        NSLog(@"hello");
//    }];
    
    SDWebImageManager *managerMap = [SDWebImageManager sharedManager];
    
    [managerMap downloadWithURL:thmbMap
                     options:0
                    progress:nil
     
                   completed:^(UIImage *imageMap, NSError *error, SDImageCacheType  SDImageCacheTypeMemory, BOOL finished)
     {
         if (imageMap)
         {
             [self.mapImage setImage:imageMap];
             
             [btnMapImage setImage:imageMap  forState:UIControlStateNormal];
             
         }

         
     }];

    
    
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
  
    [manager downloadWithURL:thmbUrl
                     options:0
                    progress:nil
     
                   completed:^(UIImage *image, NSError *error, SDImageCacheType  SDImageCacheTypeMemory, BOOL finished)
     {
         if (image)
         {
             [self.imageView setImage:image];
                         
             [btnImage setImage:image  forState:UIControlStateNormal];
             
         }
         else
         {
           
             [btnImage setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
          
         }
         
         [UIApplication sharedApplication].networkActivityIndicatorVisible =NO ;
         
     }];

    
    
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
    
    
  //  [self.imageView setImage:thumb];
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




//- (IBAction)btnCarImage:(id)sender {
//    [self setImageView:imageView];
//   
//}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if(!_imageViewController)
//    {
//        [self btnImageClick];
//    }
//}

- (IBAction)btnImageClick {
//    NSLog(@"%@",gallery1);
    FSBasicImage *photo1 = [[FSBasicImage alloc] initWithImageURL:gallery1];
    FSBasicImage *photo2 = [[FSBasicImage alloc] initWithImageURL:gallery2];
    FSBasicImage *photo3 = [[FSBasicImage alloc] initWithImageURL:gallery3];
    FSBasicImage *photo4 = [[FSBasicImage alloc] initWithImageURL:gallery4];
    FSBasicImage *photo5 = [[FSBasicImage alloc] initWithImageURL:gallery5];
    FSBasicImage *photo6 = [[FSBasicImage alloc] initWithImageURL:gallery6];
    FSBasicImage *photo7 = [[FSBasicImage alloc] initWithImageURL:gallery7];
    FSBasicImage *photo8 = [[FSBasicImage alloc] initWithImageURL:gallery8];
    FSBasicImage *photo9 = [[FSBasicImage alloc] initWithImageURL:gallery9];
    
    
//    FSBasicImage *secondPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://farm9.staticflickr.com/8023/6971840814_68614eba26_b.jpg"] name:@"Photo by Ben Fredericson (http://farm9.staticflickr.com/8023/6971840814_68614eba26_b.jpg)"];
//    FSBasicImage *failingPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:@"http://example.com/1.jpg"] name:@"Failure image"];
    
    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:@[photo1,photo2,photo3,photo4,photo5,photo6,photo7,photo8,photo9]];
    self.imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    
    _imageViewController.delegate = self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_imageViewController];
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    }
    else {
        [self.navigationController pushViewController:_imageViewController animated:YES];
    }
}

-(IBAction)btnMapClick
{
    FSBasicImage *map = [[FSBasicImage alloc] initWithImageURL:thmbMap];
    FSBasicImageSource *mapSource = [[FSBasicImageSource alloc] initWithImages:@[map]];
    self.imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:mapSource];
    
    _imageViewController.delegate = self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_imageViewController];
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    }
    else {
        [self.navigationController pushViewController:_imageViewController animated:YES];
    }

}


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


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"pushCarGallery"])
//    {
//        
//        
//        NSString *carid = [arrDetail[0] objectForKey:@"carID"];
//        
//        NSLog(@"%@",carid);
//        
//        [[segue destinationViewController] setSCarID:carid];
//        
//        
//        
//    }
//}


@end
