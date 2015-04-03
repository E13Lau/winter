//
//  MapViewController.m
//  winter
//
//  Created by command.Zi on 15/3/23.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationViewController () <MKMapViewDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource> {
    CLLocationManager * locationManager; //定义Manager
    double latitude;
    double longitude;
    int i;
    NSMutableArray * myArray;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    myArray = [[NSMutableArray alloc]init];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
//    CLLocationManager *locationManager;
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 1;
        [locationManager requestAlwaysAuthorization];
    }else {
        //提示用户无法进行定位操作
    }

    // 开始定位
    [locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"didChangeAuthorizationStatus---%u",status);
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    latitude =  coor.latitude;
    longitude = coor.longitude;
    double a = currentLocation.horizontalAccuracy;
    double v = currentLocation.verticalAccuracy;
    ++i;
    NSLog(@"%f---%d---%f",latitude,i,longitude);
    
    NSLog(@"经度=%f 纬度=%f 高度=%f 水平精度=%f 垂直进度=%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, currentLocation.altitude,a,v);
    
    [myArray addObjectsFromArray:locations];
    [_myTableView reloadData];
    //[self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        NSLog(@"%@",error);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [myArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString * string = [NSString stringWithFormat:@"%d:%@",i,myArray[indexPath.row]];
    cell.textLabel.text = string;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
