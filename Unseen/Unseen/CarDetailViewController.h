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

@interface CarDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;


- (IBAction)onChangeSeg:(id)sender;
@property (strong,nonatomic) NSString *sCarID;

@property (strong, nonatomic) IBOutlet UITextView *textViewDetail;


@end
