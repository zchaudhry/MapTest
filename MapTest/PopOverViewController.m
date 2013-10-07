//
//  PopOverViewController.m
//  MapTest
//
//  Created by Zahid Chaudhry on 10/4/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import "PopOverViewController.h"


@implementation PopOverViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
  _popOverText.text = _popOverdetailText;
  _popOverTitle.text = _popOverTitleText;
  self.preferredContentSize = CGSizeMake(300.0, 150.0);
//  self.contentSizeForViewInPopover = CGSizeMake(300, 150);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
