//
//  InfoAboutViewController.m
//  MapTest
//
//  Created by Zahid Chaudhry on 10/7/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import "InfoAboutViewController.h"

@interface InfoAboutViewController ()

@end

@implementation InfoAboutViewController

@synthesize popover;

- (void)viewDidLoad
{
    [super viewDidLoad];
  if (UIUserInterfaceIdiomPad) {
    self.preferredContentSize = CGSizeMake(400, 300);
  }
 /*
  NSString *fullURL = @"https://earthdata.nasa.gov/data/near-real-time-data/faq/firms";
  NSURL *url = [NSURL URLWithString:fullURL];
  NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  [webView loadRequest:requestObj]; */
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDonePressed:(id)sender {
 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
  [self dismissViewControllerAnimated:YES completion:Nil];
 }else{
   [popover dismissPopoverAnimated:YES];
   }
}
@end
