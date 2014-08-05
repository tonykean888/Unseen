//
//  CarDetailViewController.h
//  Unseen
//
//  Created by Tony on 7/1/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Car.h"

#import "FindResultViewController.h"
#import "CarGarlleryViewController.h"
#import "SDWebImage/SDWebImageManager.h"
#import "SDWebImage/UIButton+WebCache.h"
#import "FSBasicImage.h"
#import "FSBasicImageSource.h"
#import "FavoriteViewController.h"
#import "FMDatabaseAdditions.h"


@class Car;
@class CarDetailViewController;

@interface CarDetailViewController : UIViewController

@property (nonatomic,strong) NSMutableArray *cars;


@property(strong,nonatomic) FSImageViewerViewController *imageViewController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl ;
@property (strong, nonatomic) IBOutlet UIButton *btnImage;
- (IBAction)btnImageClick;
@property (strong, nonatomic) IBOutlet UIButton *btnMapImage;
- (IBAction)btnMapClick;
- (IBAction)onChangeSeg:(id)sender;
@property (strong,nonatomic) NSString *sCarID;
@property (strong, nonatomic) IBOutlet UITextView *textViewDetail;
@property (strong, nonatomic) IBOutlet UIScrollView *tentScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *carScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *mapImage;
@property (strong, nonatomic) IBOutlet UITextView *tentDetailText;

- (IBAction)btnAddFavorite:(id)sender;
-(BOOL)validate:(Car *) c;

@end
