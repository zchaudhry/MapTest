//
//  DetailViewController.m
//  MapTest
//
//  Created by Zahid Chaudhry on 10/3/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import "DetailViewController.h"



@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  _detailText.text = _desciptionText;
  _detailTitle.text = _titleText;
  
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMap:(id)sender {
  [self dismissViewControllerAnimated:YES completion:Nil];
}
@end
