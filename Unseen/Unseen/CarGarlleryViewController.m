//
//  CarGarlleryViewController.m
//  Unseen
//
//  Created by Tony on 7/4/2557 BE.
//  Copyright (c) 2557 Unseencar. All rights reserved.
//

#import "CarGarlleryViewController.h"

@interface CarGarlleryViewController ()
{
    NSMutableArray *imageObj;
    
}
@end

@implementation CarGarlleryViewController
@synthesize sCarID;

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
    imageObj = [[NSMutableArray alloc]init];
    NSLog(@"%@",sCarID);
    int i ;
    NSString *strFolder =[sCarID substringWithRange:NSMakeRange(5, 2)];
    for(i =1;i<=9;i++)
    {
        NSString *num =[NSString stringWithFormat:@"%d.jpg",i];
        
        NSString *imageName = [sCarID stringByAppendingString:num];
        
        NSString *strThumbURL = [NSString stringWithFormat:@"http://www.unseencar.com/carpic/%@/L/%@",strFolder,imageName];
        NSLog(@"%@",strThumbURL);
        
        [imageObj addObject:strThumbURL];
    }
    
    pageControlBeingeUsed = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHight = screenRect.size.height;
    
    for (int j=0; j < [imageObj count]; j++)
    {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * j;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        NSURL *val = [NSURL URLWithString:[imageObj objectAtIndex:j]];
         NSData *imageData = [NSData dataWithContentsOfURL:val];
        
        UIImage *theImage = [UIImage imageWithData:imageData];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth * j, 0, screenWidth, screenHight)];
        img.image = theImage;
        [self.scrollView addSubview:img];
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [imageObj count], self.scrollView.frame.size.height + 300);
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [imageObj count];
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (!pageControlBeingeUsed) {
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
        self.pageControl.currentPage = page;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlBeingeUsed = NO;
}

-(void)scrollViewDidEnableDecelerating:(UIScrollView *)scrollView
{
    pageControlBeingeUsed = NO;
}

-(IBAction)changePage{
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    pageControlBeingeUsed = YES;
    
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

@end
