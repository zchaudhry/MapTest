//
//  PopOverViewController.h
//  MapTest
//
//  Created by Zahid Chaudhry on 10/4/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopOverViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UILabel *popOverTitle;
@property (weak, nonatomic) IBOutlet UITextView *popOverText;
@property (nonatomic) NSString *popOverTitleText;
@property (nonatomic) NSString *popOverdetailText;
@end
