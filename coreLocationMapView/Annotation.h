//
//  Annotation.h
//  coreLocationMapView
//
//  Created by Virendra on 7/13/15.


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic ,copy)NSString *title;
@property(nonatomic ,copy)NSString *subtitle;


@end
