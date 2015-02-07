//
//  FiveViewController.m
//  winter
//
//  Created by command.Zi on 15/2/4.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "FiveViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "MZTimerLabel.h"

@interface FiveViewController () {
    CGFloat xxx;
    CGFloat yyy;
    CGFloat zzz;
    int i;
    MZTimerLabel * MZTtime;
    
    CGFloat roll;
}

@property(readonly, nonatomic) CMAcceleration * acceleration;
@property(strong, nonatomic) CMDeviceMotion * deviceMotion;
@property(strong, nonatomic) CMMotionManager * motionManager;

@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *xxxLabel;
@property (strong, nonatomic) IBOutlet UILabel *yyyLabel;
@property (strong, nonatomic) IBOutlet UILabel *zzzLabel;


@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.motionManager = [CMMotionManager new];
    
    MZTtime = [[MZTimerLabel alloc]initWithLabel:self.timeLabel];
    MZTtime.timeFormat = @"HH:mm:ss";
    [MZTtime start];
    
    i = 0;
//    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
//        CMDeviceMotion * newMotion = motion;
//        xxx = newMotion.userAcceleration.x;
//        yyy = newMotion.userAcceleration.y;
//        zzz = newMotion.userAcceleration.z;
//        
//        NSLog(@"%.2f-----%.2f------%f",xxx,yyy,zzz);
//        self.xxxLabel.text = [NSString stringWithFormat:@"%f",xxx];
//        self.yyyLabel.text = [NSString stringWithFormat:@"%f",yyy];
//        self.zzzLabel.text = [NSString stringWithFormat:@"%f",zzz];
//        if (xxx+yyy+zzz >= 1.50f) {
//            i++;
//            self.myLabel.text = [NSString stringWithFormat:@"%d",i];
//        }
//    }];
    
    self.motionManager.deviceMotionUpdateInterval = 0.1f;
    [self.motionManager startDeviceMotionUpdates];

    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(getdeviceMotion) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

-(void)getdeviceMotion {
    xxx = self.motionManager.deviceMotion.userAcceleration.x;
    yyy = self.motionManager.deviceMotion.userAcceleration.y;
    zzz = self.motionManager.deviceMotion.userAcceleration.z;
    if (fabsf(xxx)+fabsf(yyy)+fabsf(zzz) >= 1.0f) {
        i++;
        self.myLabel.text = [NSString stringWithFormat:@"%d",i];
        
    }
    NSLog(@"%f-----%f------%f",xxx,yyy,zzz);
    
}



-(void)setTime {
    
}

- (void)didReceiveMemoryWarning {
    [self.motionManager stopDeviceMotionUpdates];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
