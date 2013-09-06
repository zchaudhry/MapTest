//
//  MapTestViewController.m
//  MapTest
//
//  Created by Zahid Chaudhry on 8/31/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import "MapTestViewController.h"
#import "MyCustomAnnotation.h"

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
  
  
  NSData *resData = [NSData  dataWithContentsOfURL:[NSURL URLWithString:@"http://firms.modaps.eosdis.nasa.gov/active_fire/text/USA_contiguous_and_Hawaii_24h.csv"]];
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
    NSString *brightness = [NSString stringWithFormat:@"Brightness Temp: %@Kelvin", bright];
    NSString *fireRadiativePotential = [NSString stringWithFormat:@"Fire Radiative Potential: %@MW acquired on %@ at %@ with %@ %% Confidence using %@ satellite.", frp,[components  objectAtIndex:5],[components  objectAtIndex:6],conf, satellite];
    
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
  [mapView deselectAnnotation:view.annotation animated:YES];
  //Alert View to show description
  UIAlertView *message = [[UIAlertView alloc] initWithTitle:view.annotation.title
                                                    message:view.annotation.description
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
  [message show];
  
  
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}

@end
