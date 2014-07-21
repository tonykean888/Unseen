//
//  CarDetailViewController.h
//  Unseen
//
//  Created by Tony on 7/1/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindResultViewController.h"
#import "CarGarlleryViewController.h"
#import "SDWebImage/SDWebImageManager.h"
#import "SDWebImage/UIButton+WebCache.h"
#import "FSBasicImage.h"
#import "FSBasicImageSource.h"


@interface CarDetailViewController : UIViewController<FSImageViewerViewControllerDelegate>

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


@end
