//
//  MapTestViewController.m
//  MapTest
//
//  Created by Zahid Chaudhry on 8/31/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import "MapTestViewController.h"
#import "MyCustomAnnotation.h"
#import "DetailViewController.h"
#import "PopOverViewController.h"
#import "InfoAboutViewController.h"

@interface MapTestViewController ()

@end

@implementation MapTestViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
  [self.busyView startAnimating];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
  //set delegate very important step for custom annotation markers to showup
  _mapView.delegate = self;
  MKCoordinateRegion region;
  region.center.latitude = 45.5200;
  region.center.longitude = -122.6819;
  region.span.longitudeDelta = 10.0f;
  region.span.latitudeDelta = 10.0f;
  [_mapView setRegion:region animated:YES];
  [self loadData];
    
}
// once map is loaded and zoom to desired area, call the load data....
-(void)loadData{
  //get the MODIS DAta
  
  //0 -latitude,1- longitude,2- brightness,3- scan,4- track,
  //5- acq_date,6- acq_time,7- satellite, 8- confidence,9- version,10- bright_t31,11- sfrp
  
  // error handling
  NSError *error = nil;
  NSData *resData = [NSData  dataWithContentsOfURL:[NSURL URLWithString:@"http://firms.modaps.eosdis.nasa.gov/active_fire/text/USA_contiguous_and_Hawaii_24h.csv"] options:NSDataReadingMappedAlways error:&error];
 // Alert users if loading data from NASA failed
  if (error != NULL) {
    NSLog(@"%ul", resData.length);
    [self.busyView stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    //Alert View to show Error
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                      message:@"Error Loading data from NASA, please try again later"
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];

  }
  else
  {
    
  NSString *csvString = [[NSString alloc] initWithData:resData encoding:NSUTF8StringEncoding];
  NSString *strip1 = [csvString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
  NSString *strip2 = [strip1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
  NSArray *rows = [strip2 componentsSeparatedByString:@"\n"];
  NSArray *components;
  CLLocationCoordinate2D coord;
  for(int i=0; i<[rows count]; i++){
    
    if(i==0 || [[rows objectAtIndex:i] isEqualToString:@""]){
      continue;
    }
    components = [[rows objectAtIndex:i] componentsSeparatedByString:@","];
    
    NSString *latitude = [components objectAtIndex:0];
    NSString *longitude = [components objectAtIndex:1];
    
    // get brightness confidence, and FRP values
    NSString *bright = [components objectAtIndex:2];
    NSString *frp = [components objectAtIndex:11];
    NSString *conf = [components objectAtIndex:8];
    NSString *satellite = [components objectAtIndex:7];
    if ([satellite isEqual: @"A"]) {
      satellite = @"Aqua";
    }else{
      satellite = @"Terra";
    }
    NSString *usedSatellite = [NSString stringWithFormat:@"Collected using %@ satellite", satellite];
    NSString *brightness = [NSString stringWithFormat:@"Brightness Temp: %@ Kelvin", bright];
    
    
    //0 -latitude,1- longitude,2- brightness,3- scan,4- track,
    //5- acq_date,6- acq_time,7- satellite, 8- confidence,9- version,10- bright_t31,11- sfrp
    
    NSString *fireRadiativePotential = [NSString stringWithFormat:@"Fire Radiative Potential: %@ MW, along scan %@ pixel size  and track %@ pixel size, acquired on %@ at %@ (UTC) with %@ %% Confidence using %@ satellite. Collection and source version: %@", frp, [components objectAtIndex:3],[components objectAtIndex:4],[components  objectAtIndex:5],[components  objectAtIndex:6],conf, satellite, [components objectAtIndex:9]];
    
    double lat = [latitude doubleValue];
    double lon = [longitude doubleValue];
    
    coord.latitude = lat;
    coord.longitude = lon;
    
    MyCustomAnnotation *ann = [[MyCustomAnnotation alloc] initWithCoordinate:coord];
    ann.title = brightness;
    ann.subtitle = usedSatellite;
    ann.description= fireRadiativePotential;
    [_mapView addAnnotation:ann];       
  }
  }
 
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
  
  static NSString *annAddedIdentifier=@"annAddedIdentifier";
  [self.busyView stopAnimating];
[UIApplication sharedApplication].networkActivityIndicatorVisible = false;
  if([annotation isKindOfClass:[MyCustomAnnotation class]]){
    //Try to get an unused annotation, similar to uitableviewcells
    MKAnnotationView *annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:annAddedIdentifier];
    //If one isn't available, create a new one
    if(!annotationView){
      annotationView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annAddedIdentifier];
      
      annotationView.image=[UIImage imageNamed:@"iFire.png"];
      //add detail button
      annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
      annotationView.canShowCallout = YES;
      
    }
    
    return annotationView;
  }
  
    return nil;
}
// TODO: add custom callout
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
  
  
  
  //Alert View to show description
//  UIAlertView *message = [[UIAlertView alloc] initWithTitle:view.annotation.title
                                   //                 message:view.annotation.description
                                //                   delegate:self
                              //            cancelButtonTitle:@"OK"
                             //           otherButtonTitles:nil];
  
   //
  DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
  
  detailView.titleText = view.annotation.title;
  detailView.desciptionText = view.annotation.description;
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
    [mapView deselectAnnotation:view.annotation animated:YES];
  [self presentViewController:detailView animated:YES completion:nil];
  }else{
    
    PopOverViewController *popView =[[PopOverViewController alloc] initWithNibName:@"PopOverViewController" bundle:nil];
    
    popView.popOverTitleText =view.annotation.title;
    popView.popOverdetailText = view.annotation.description;
    _popOver =[[UIPopoverController alloc] initWithContentViewController:popView];
  //  CGRect recSize = CGRectMake(10.0f, 10.0f, 1.0f, 1.0f);
    
   UIButton *navButton = (UIButton *) control;
    [_popOver presentPopoverFromRect:[navButton bounds] inView:navButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    //[message show];
  }
  
  }
- (IBAction)basemapChanged:(id)sender{
    UISegmentedControl* segControl = (UISegmentedControl*)sender;
  switch (segControl.selectedSegmentIndex) {
    case 0:
      self.mapView.mapType = MKMapTypeStandard;
      break;
    case 1:
      self.mapView.mapType = MKMapTypeSatellite;
      break;
    case 2:
      self.mapView.mapType = MKMapTypeHybrid;
      break;
    default:
      break;

}
}

- (IBAction)zoomToLocation:(id)sender {
  if (self.mapView.showsUserLocation) {
    self.mapView.showsUserLocation = false;
    [sender setTitle:@"Show Location"];
   //  [sender setAlpha:0.30f];
  }else{
    
    self.mapView.showsUserLocation = true;
    MKCoordinateRegion region;
    region.center = _mapView.userLocation.coordinate;
    region.span = MKCoordinateSpanMake(3.0, 3.0);
    
    region = [_mapView regionThatFits:region];
    [_mapView setRegion:region animated:YES];
    [sender setTitle:@"Hide Location"];
  }
}
// get a screen capture
- (IBAction)Print:(id)sender {
  UIGraphicsBeginImageContext(self.mapView.frame.size);
  [self.mapView.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *viewimage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  UIImageWriteToSavedPhotosAlbum(viewimage, nil, Nil, nil);
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
  if ( !_initialLocation )
  {
    self.initialLocation = userLocation.location;
    
    MKCoordinateRegion region;
    region.center = mapView.userLocation.coordinate;
    region.span = MKCoordinateSpanMake(3.0, 3.0);
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
  }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}
// load different views for iphone and ipad for about information
- (IBAction)showAbout:(id)sender {
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
    InfoAboutViewController *infoView = [[InfoAboutViewController alloc]initWithNibName:@"InfoAboutViewController" bundle:Nil];
    [self presentViewController:infoView animated:YES completion:Nil];
  
  } else{
    // for IPAD
    
    InfoAboutViewController *infoViewForIpad =[[InfoAboutViewController alloc]initWithNibName:@"InfoAboutViewControllerIPad" bundle:Nil];
    
   infoViewForIpad.popover = [[UIPopoverController alloc] initWithContentViewController:infoViewForIpad];
  //  CGRect recSize = CGRectMake(10.0f, 10.0f, 1.0f, 1.0f);
  //  UIButton* btn = (UIButton *)sender;
    [infoViewForIpad.popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
  
  }
}
@end
