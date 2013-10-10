//
//  MapTestViewController.h
//  MapTest
//
//  Created by Zahid Chaudhry on 8/31/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"
@interface MapTestViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>{
  
}
@property(nonatomic,retain)  UIPopoverController *popOver;
@property (nonatomic, retain) CLLocation* initialLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnInfo;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)showAbout:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busyView;
- (IBAction)basemapChanged:(id)sender;
- (IBAction)zoomToLocation:(id)sender;
- (IBAction)Print:(id)sender;
-(void)loadData;
@end
