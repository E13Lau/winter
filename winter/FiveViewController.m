//
//  FiveViewController.m
//  winter
//
//  Created by command.Zi on 15/2/4.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//
//
//
//  iOS 5s 以上使用M7协处理器
//
//
//
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
    
    CGFloat tempxxx;
    CGFloat tempyyy;
    CGFloat tempzzz;
    int a ;
}

@property(readonly, nonatomic) CMAcceleration * acceleration;
@property(strong, nonatomic) CMDeviceMotion * deviceMotion;
@property(strong, nonatomic) CMMotionManager * motionManager;

@property(strong, nonatomic) CMAttitude * attitude;
@property (nonatomic, strong) CMPedometer *stepCounter;
@property (nonatomic, strong) NSOperationQueue *operationQueue;



@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *xxxLabel;
@property (strong, nonatomic) IBOutlet UILabel *yyyLabel;
@property (strong, nonatomic) IBOutlet UILabel *zzzLabel;
@property (strong, nonatomic) IBOutlet UILabel *nextLabel;
@property (strong, nonatomic) IBOutlet UILabel *nextnextLabel;
@property (strong, nonatomic) IBOutlet UILabel *myLabeltwo;


@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    if (([CMPedometer isStepCountingAvailable] || [CMMotionActivityManager isActivityAvailable])) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        //更新label
        if ([CMPedometer isStepCountingAvailable]) {
            
            self.stepCounter = [[CMPedometer alloc] init];
            
            [self.stepCounter startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                if (error) {
                    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Opps!" message:@"error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [error show];
                }
                else {
                    NSNumber * stepNumbers = pedometerData.numberOfSteps;
                    
                    NSString *text = [NSString stringWithFormat:@"步数: %d",stepNumbers.intValue];
                    
                    self.myLabeltwo.text = text;
                }
                }];
        }
    }
    
    

    self.motionManager = [CMMotionManager new];
    
    MZTtime = [[MZTimerLabel alloc]initWithLabel:self.timeLabel];
    MZTtime.timeFormat = @"HH:mm:ss";
    [MZTtime start];
    
    i = 0;
    self.motionManager.deviceMotionUpdateInterval = 0.05f;
    [self.motionManager startDeviceMotionUpdates];

    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(getdeviceMotion) userInfo:nil repeats:YES];
    
    
    // Do any additional setup after loading the view.
}



-(void)getdeviceMotion {
    tempxxx = self.motionManager.deviceMotion.userAcceleration.x;
    tempyyy = self.motionManager.deviceMotion.userAcceleration.y;
    tempzzz = self.motionManager.deviceMotion.userAcceleration.z;
    if (tempxxx > 0.7) {
        xxx = tempxxx > xxx ? tempxxx:xxx;
        if (fabsf(tempxxx)<fabsf(xxx)) {
            a++;
            NSLog(@"%d",a);
            xxx = 0;
            tempxxx = 0;
            self.myLabel.text = [NSString stringWithFormat:@"%d",a];
        }
    }
//    xxx = self.motionManager.deviceMotion.userAcceleration.x;
//    yyy = self.motionManager.deviceMotion.userAcceleration.y;
//    zzz = self.motionManager.deviceMotion.userAcceleration.z;
    self.xxxLabel.text = [NSString stringWithFormat:@"%f",xxx];
    self.yyyLabel.text = [NSString stringWithFormat:@"%f",yyy];
    self.zzzLabel.text = [NSString stringWithFormat:@"%f",zzz];
//    if (fabsf(xxx)+fabsf(yyy)+fabsf(zzz) >= 1.0f) {
//        i++;
//        self.myLabel.text = [NSString stringWithFormat:@"%d",i];
//        
//    }
//    NSLog(@"%f-----%f------%f",xxx,yyy,zzz);

    self.nextLabel.text = [NSString stringWithFormat:@"%@",self.motionManager.deviceMotion.attitude];
    self.nextnextLabel.text = [NSString stringWithFormat:@"%f----%f----%f",self.motionManager.deviceMotion.rotationRate.x,self.motionManager.deviceMotion.rotationRate.y,self.motionManager.deviceMotion.rotationRate.z];
    
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
