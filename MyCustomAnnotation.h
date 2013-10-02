//
//  MyCustomAnnotation.h
//  MapTest
//
//  Created by Zahid Chaudhry on 8/31/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyCustomAnnotation : NSObject <MKAnnotation>{
NSString *title;
NSString *subtitle;
NSString *descriptoin;
CLLocationCoordinate2D _coordinate;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coordinate;

@end
