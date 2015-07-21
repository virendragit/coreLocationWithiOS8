//
//  ViewController.m
//  coreLocationMapView
//
//  Created by Virendra on 7/13/15.


#import "ViewController.h"
#import "Annotation.h"

#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLbl;
@property (weak, nonatomic) IBOutlet UILabel *longitude;

@property (strong,nonatomic) CLLocationManager *locationManager;

@end


//set coordinate
#define WIMB_LATITUDE 51.434783
#define WIMB_LONGITUDE -0.213428

@implementation ViewController

@synthesize locationManager;
- (IBAction)StartUpdatingLocation:(id)sender {
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.distanceFilter = 10;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    
    
    self.MapView.delegate = self;
    
    
}

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
    
    CLLocation *crnLoc =  [locations lastObject];
    
    _latitudeLbl.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude];
    _longitude.text = [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude];
    
    
    self.MapView.region = MKCoordinateRegionMake(crnLoc.coordinate, MKCoordinateSpanMake(0.01, 0.01));
    
    
//    altitude.text = [NSString stringWithFormat:@"%.0f m",crnLoc.altitude];
//    speed.text = [NSString stringWithFormat:@"%.1f m/s", crnLoc.speed];
    
    //showing annotation in mapview
   // 1.create coordicate
    
    CLLocationCoordinate2D wimblocation ;
    wimblocation.latitude = WIMB_LATITUDE;
    wimblocation.latitude = WIMB_LONGITUDE;
    
    Annotation *newAnnotation = [[Annotation alloc]init];
    newAnnotation.coordinate =wimblocation;
    newAnnotation.title = @"Wimbledon";
      newAnnotation.subtitle = @"NOVO won this time";
    
    [self.MapView addAnnotation:newAnnotation];
    
    
   
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{

    
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%g",
                                 newLocation.coordinate.latitude];
    _latitudeLbl.text = currentLatitude;
    
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%g",
                                  newLocation.coordinate.longitude];
    _longitude.text = currentLongitude;
    
//    NSString *currentHorizontalAccuracy =
//    [[NSString alloc]
//     initWithFormat:@"%g",
//     newLocation.horizontalAccuracy];
//    horizontalAccuracy.text = currentHorizontalAccuracy;
//    
//    NSString *currentAltitude = [[NSString alloc]
//                                 initWithFormat:@"%g",
//                                 newLocation.altitude];
//    altitude.text = currentAltitude;
//    
//    NSString *currentVerticalAccuracy =
//    [[NSString alloc]
//     initWithFormat:@"%g",
//     newLocation.verticalAccuracy];
//    verticalAccuracy.text = currentVerticalAccuracy;
//    
//    if (startLocation == nil)
//        self.startLocation = newLocation;
//    
//    CLLocationDistance distanceBetween = [newLocation
//                                          distanceFromLocation:startLocation];
//    
//    NSString *tripString = [[NSString alloc]
//                            initWithFormat:@"%f",
//                            distanceBetween];
//    distance.text = tripString;
}
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    NSLog(@"map is loading ");
}


- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation:(id<MKAnnotation>) annotation
{
    if (annotation == mapView.userLocation)
    {
        return nil;
    }
    else
    {
        MKAnnotationView *pin = (MKAnnotationView *) [self.MapView dequeueReusableAnnotationViewWithIdentifier: @"VoteSpotPin"];
        if (pin == nil)
        {
            pin = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"TestPin"] ;
        }
        else
        {
            pin.annotation = annotation;
        }
        
        [pin setImage:[UIImage imageNamed:@"TestPin.png"]];
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
