//
//  MyCustomAnnotation.m
//  MapTest
//
//  Created by Zahid Chaudhry on 8/31/13.
//  Copyright (c) 2013 Zahid Chaudhry. All rights reserved.
//

#import "MyCustomAnnotation.h"

@implementation MyCustomAnnotation

@synthesize title;
@synthesize subtitle;
@synthesize description;
@synthesize coordinate = _coordinate;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coordinate{
  self=[super init];
  if(self){
    _coordinate=coordinate;
    
  }
  return self;
}



@end
