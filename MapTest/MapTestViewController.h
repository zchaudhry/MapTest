//
//  MapTestViewController.h
//  MapTest
//
//  Created by Zahid Chaudhry on 8/31/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface MapTestViewController : UIViewController<MKMapViewDelegate>{
  
}
@property(nonatomic,retain)  UIPopoverController *popOver;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busyView;
- (IBAction)basemapChanged:(id)sender;
-(void)loadData;
@end
