//
//  CarDetailViewController.m
//  Unseen
//
//  Created by Tony on 7/1/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarDetailViewController.h"


@interface CarDetailViewController ()<FSImageViewerViewControllerDelegate>
{
    

    NSMutableDictionary *dict;
    NSString *carDetail,*tentDetail;
    NSString *strCarID,*strBrand,*strModel,*strDetail,*strSubModel,*strPrices,*strPricesDown,*strMap,
    *strCarInt,*strCarExt,*strTentName,*strTentAddr,*strTentTel,*strThumbURL,*strGallery1 ,*strGallery2,
    *strGallery3,*strGallery4,*strGallery5,*strGallery6,*strGallery7,*strGallery8,*strGallery9;
    NSMutableArray *arrDetail;
    NSURL *thmbUrl,*thmbMap,*gallery1,*gallery2,*gallery3,*gallery4,
           *gallery5,*gallery6,*gallery7,*gallery8,*gallery9;

}
@end

@implementation CarDetailViewController

@synthesize segmentControl,imageView,textViewDetail,sCarID,tentScrollView,carScrollView,
mapImage,tentDetailText,btnImage,btnMapImage,cars;

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
    
    
    NSString *strUrl = [NSString stringWithFormat:@"http://localhost/unseen/CarDetail.php?carID=%@",sCarID];
    
    NSLog(@"url %@",strUrl);
    
    
    NSData *jsonResult = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonResult options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObj)
    {
         strCarID = [dataDict objectForKey:@"car_id"];
         strBrand = [dataDict objectForKey:@"brand_name"];
         strModel = [dataDict objectForKey:@"model"];
         strDetail = [dataDict objectForKey:@"sub_detail"];
         strSubModel = [dataDict objectForKey:@"sub_submodel"];
         strPrices = [dataDict objectForKey:@"prices"];
         strPricesDown = [dataDict objectForKey:@"free_down"];
         strCarInt = [dataDict objectForKey:@"car_interior"];
         strCarExt = [dataDict objectForKey:@"car_exterior"];
         strTentName = [dataDict objectForKey:@"name"];
         strTentAddr = [dataDict objectForKey:@"address"];
         strTentTel = [dataDict objectForKey:@"tel_office"];
         strThumbURL = [dataDict objectForKey:@"thumb"];
         strMap = [dataDict objectForKey:@"map"];
         strGallery1 = [dataDict objectForKey:@"gallery1"];
         strGallery2 = [dataDict objectForKey:@"gallery2"];
         strGallery3 = [dataDict objectForKey:@"gallery3"];
         strGallery4 = [dataDict objectForKey:@"gallery4"];
         strGallery5 = [dataDict objectForKey:@"gallery5"];
         strGallery6 = [dataDict objectForKey:@"gallery6"];
         strGallery7 = [dataDict objectForKey:@"gallery7"];
         strGallery8 = [dataDict objectForKey:@"gallery8"];
         strGallery9 = [dataDict objectForKey:@"gallery9"];
  
    }
    
    //NSLog(@"%@",strThumbURL);
    
    thmbUrl = [NSURL URLWithString:strThumbURL];
    thmbMap = [NSURL URLWithString:strMap];
    gallery1 = [NSURL URLWithString:strGallery1];
    gallery2 = [NSURL URLWithString:strGallery2];
    gallery3 = [NSURL URLWithString:strGallery3];
    gallery4 = [NSURL URLWithString:strGallery4];
    gallery5 = [NSURL URLWithString:strGallery5];
    gallery6 = [NSURL URLWithString:strGallery6];
    gallery7 = [NSURL URLWithString:strGallery7];
    gallery8 = [NSURL URLWithString:strGallery8];
    gallery9 = [NSURL URLWithString:strGallery9];
    
  //  NSData *thmbMapData = [NSData dataWithContentsOfURL:thmbMap];
  //  UIImage *map = [UIImage imageWithData:thmbMapData];
    
 
    
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
         [UIApplication sharedApplication].networkActivityIndicatorVisible =YES ;
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

    
    
    carDetail = [NSString stringWithFormat:@"%@ %@ %@ %@ \rราคา : %@ บาท\rดาวน์ %@\r\rอุปกรณ์เสริมภายใน \r%@ \r\rอุปกรณ์เสริมภายนอก\r%@ \r" ,strBrand,strModel,strSubModel,strDetail,strPrices,strPricesDown,strCarInt,strCarExt];
    
    
    tentDetail = [NSString stringWithFormat:@"ชื่อเต็นท์ : %@ \rที่อยู่ :%@ \rเบอร์โทรศัพท์ :%@ \r ",
                  strTentName,strTentAddr,strTentTel];
    
    
  //  [self.imageView setImage:thumb];
    [self.segmentControl setSelectedSegmentIndex:0];
    [textViewDetail setText:carDetail];
    
    
    
    
    //[mapImage setImage:map];
    
    
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

- (IBAction)btnAddFavorite:(id)sender {
    FavoriteDataAccess *db = [[FavoriteDataAccess alloc] init];
    //[db createDataBase];
    
    
    Car *car = [[Car alloc] init];
    car.brand = strBrand;
    car.model = strModel;
    car.carid = strCarID;
    car.detail = strDetail;
    car.subModel = strSubModel;
    car.prices = strPrices;
    car.image = strThumbURL;
 
    
    if (![self validate:car]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!!!" message:@"ข้อมูลผิดพลาด"
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
        [alert show];
        return;
    }else{
         [db saveFavoriteCar:car];
    }
    NSArray *dataCar = [[NSArray alloc] init];
    dataCar = [db findCarData];
   // NSLog(@"%d",dataCar.count);
    
    //[self.delegate addFavoriteViewController:self didAddFavorite:car];
   // [self.delegate test:self :car];
    
    
    
    
  //  NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    
    


        
    //}

}


-(BOOL)validate:(Car *)c
{
    if ([c.brand length] == 0 ||[c.model length]== 0||[c.carid length] == 0||
        [c.detail length] == 0 || [c.subModel length]==0 || [c.prices length] == 0||
        [c.image length] == 0)
    {
      
        return NO;
    }
   
    return YES;
}

@end
