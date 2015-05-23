//
//  ScrollViewViewController.m
//  winter
//
//  Created by command.Zi on 15/1/19.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "ScrollViewViewController.h"
#import <POP.h>
#import "LZPickerView.h"

@interface ScrollViewViewController () <UIScrollViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,LZPicderViewDelegate> {
    NSValue * oldframe;
    BOOL animationbool;
    UITapGestureRecognizer * tapaaa;
}

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIPageControl *PageControlView;
@property (weak, nonatomic) IBOutlet UIScrollView *myscroll;
@property (nonatomic, strong) NSArray *imgarr;   //????
@end
#define IOS_SCREEN_HEIGHT [UIScreen mainScreen ].bounds.size.height//实际的屏幕高度

#define IOS_SCREEN_WIDTH [UIScreen mainScreen ].bounds.size.width//实际的屏幕宽度
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation ScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    tapaaa = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aaa)];

    _myscroll.pagingEnabled = YES;
    _myscroll.backgroundColor = [UIColor clearColor];
    _imgarr = @[@"3.png",@"0.jpg", @"1.jpg", @"2.png", @"3.png",@"0.jpg"];
    _myscroll.contentSize = CGSizeMake(_imgarr.count*IOS_SCREEN_WIDTH, 200);
    NSLog(@"%f",IOS_SCREEN_WIDTH);
    for (int i = 0; i<_imgarr.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(IOS_SCREEN_WIDTH*i, 0, IOS_SCREEN_WIDTH, 200)];
        img.image = [UIImage imageNamed:_imgarr[i]];
        
        [_myscroll addSubview:img];
    }
    _myscroll.delegate = self;
    [_myscroll addGestureRecognizer:tapaaa];

    oldframe = [NSValue valueWithCGRect:CGRectMake(0, 0, IOS_SCREEN_WIDTH, 200)];
    

    self.PageControlView.numberOfPages = [_imgarr count]-2;
    
    // Do any additional setup after loading the view.
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    UIViewController * controller = viewController;
    return controller;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    UIViewController * controller = viewController;
    return controller;
}

-(void)aaa {
    NSLog(@"AASVV");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x <=0) {
        CGPoint abc = CGPointMake(IOS_SCREEN_WIDTH*(_imgarr.count-2), 0);
        [scrollView setContentOffset:abc animated:NO];
    }if (scrollView.contentOffset.x>=(_imgarr.count-1)*IOS_SCREEN_WIDTH) {
        CGPoint abc = CGPointMake(IOS_SCREEN_WIDTH, 0);
        [scrollView setContentOffset:abc animated:NO];
    }
}

- (void)spring:(NSValue *)value {
    POPSpringAnimation * framePOP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    framePOP.springSpeed = 10.f;
    framePOP.springBounciness = 4.f;
    framePOP.toValue = value;
    [framePOP setCompletionBlock:^(POPAnimation * anim , BOOL finsih) {
        if (finsih) {
            NSLog(@"view.frame = %@",NSStringFromCGRect(self.myscroll.frame));
        }
    }];
    [_myscroll pop_addAnimation:framePOP forKey:@"go"];
    
}

-(void)basic{
    
    POPBasicAnimation* basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    
    basicAnimation.toValue = [NSNumber numberWithFloat:CGRectGetWidth(_myscroll.frame)/2.0];
    
    basicAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // basicAnimation.duration = 3.f;
    
    [basicAnimation setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
        
        if (fin) {
            
            NSLog(@"view.frame = %@",NSStringFromCGRect(_myscroll.frame));
            
             POPBasicAnimation* newBasic = [POPBasicAnimation easeInEaseOutAnimation];
            
             newBasic.property = [POPAnimatableProperty propertyWithName:kPOPLayerCornerRadius];
            
             newBasic.toValue = [NSNumber numberWithFloat:0];
            
             [_myscroll.layer pop_addAnimation:newBasic forKey:@"go"];

        }
        
    }];
    
    POPSpringAnimation * springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    springAnimation.springSpeed = 12.0f;
    springAnimation.springBounciness = 4.0f;
    [springAnimation setCompletionBlock:^(POPAnimation * animation, BOOL finsh) {
        if (finsh) {
            POPSpringAnimation * newspringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            newspringAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height, 0, 0)];
            newspringAnimation.springSpeed = 12.0f;
            newspringAnimation.springBounciness = 4.0f;
            [_myscroll pop_addAnimation:newspringAnimation forKey:@"newSpring"];
        }
    }];
    
    [_myscroll pop_addAnimation:springAnimation forKey:@"spring"];
    [_myscroll.layer pop_addAnimation:basicAnimation forKey:@"frameChange"];
}


#pragma mark ViewAction
-(IBAction)aa:(id)sender {
//    [self basic];
//    if (animationbool) {
//        NSValue * newframe = [NSValue valueWithCGRect:CGRectMake(0, 500, 0, 0)];
//        [self spring:newframe];
//        animationbool = NO;
//    }else {
//        [self spring:oldframe];
//        animationbool = YES;
//    }
    
    LZPickerView * pickerView = [[LZPickerView alloc]initWithMenuArray:@[@"aaa",@"BBBB"]];
    pickerView.delegate = self;
    [pickerView show];
}

-(void)lzPickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

-(void)lzDatePickerViewValueChanged:(UIDatePicker *)datePickerView value:(NSDate *)date {
    NSLog(@"%@",date);
}

-(void)group

{
    
    _myscroll.transform = CGAffineTransformMakeRotation(M_PI_2/3);
    
    POPBasicAnimation* spring = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    spring.beginTime = CACurrentMediaTime();
    
    spring.duration = .4f;
    
    spring.fromValue = [NSNumber numberWithFloat:-100.f];
    
    spring.toValue = [NSNumber numberWithFloat:CGRectGetMinY(_myscroll.frame) + 80];
    
    [spring setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
        
    }];
    
    POPBasicAnimation* basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    basic.beginTime = CACurrentMediaTime();
    
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    basic.toValue = [NSNumber numberWithFloat:-M_PI_4];
    
    basic.duration = .4f;
    
    POPBasicAnimation* rotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    rotation.beginTime = CACurrentMediaTime() + .4f;
    
    rotation.toValue = [NSNumber numberWithFloat:0.f];
    
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    rotation.duration = .25f;
    
    POPBasicAnimation* donw = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    donw.beginTime = CACurrentMediaTime() + 0.4f;
    
    donw.toValue = [NSNumber numberWithFloat:CGRectGetMinY(_myscroll.frame)];
    
    donw.duration = .25f;
    
    donw.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [_myscroll.layer pop_addAnimation:spring forKey:@"spring"];
    
    [_myscroll.layer pop_addAnimation:basic forKey:@"basic"];
    
    [_myscroll.layer pop_addAnimation:donw forKey:@"down"];
    
    [_myscroll.layer pop_addAnimation:rotation forKey:@"rotation"];
    
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
