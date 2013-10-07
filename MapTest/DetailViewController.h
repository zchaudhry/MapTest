//
//  DetailViewController.h
//  MapTest
//
//  Created by Zahid Chaudhry on 10/3/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *detailTitle;
@property (nonatomic, strong) IBOutlet UITextView *detailText;
@property (nonatomic) NSString *desciptionText;
@property (nonatomic) NSString *titleText;
- (IBAction)showMap:(id)sender;

@end
