//
//  CarDetail.h
//  Unseen
//
//  Created by Tony on 7/7/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetail : UIScrollView



@property (strong, nonatomic) IBOutlet UIView *cardetailView;
@property (strong, nonatomic) IBOutlet UITextView *carDetailText;

@property (strong, nonatomic) IBOutlet UIView *tentDetailView;

@property (strong, nonatomic) IBOutlet UIImageView *tentImage;

@property (strong, nonatomic) IBOutlet UITextView *tentDetailText;

@end
