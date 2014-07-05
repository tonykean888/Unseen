//
//  CarGarlleryViewController.h
//  Unseen
//
//  Created by Tony on 7/4/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarGarlleryViewController : UIViewController
{
    BOOL pageControlBeingeUsed;
}
@property (retain,nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain,nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak,nonatomic) NSString  *sCarID;;

-(IBAction)changePage;

@end



