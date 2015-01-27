//
//  ScrollViewViewController.m
//  winter
//
//  Created by command.Zi on 15/1/19.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "ScrollViewViewController.h"
#import <POP.h>

@interface ScrollViewViewController () <UIScrollViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate> {
    NSValue * oldframe;
    BOOL animationbool;
    UITapGestureRecognizer * tapaaa;
}

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIPageControl *PageControlView;
@property (weak, nonatomic) IBOutlet UIScrollView *myscroll;
@property (nonatomic, strong) NSArray *imgarr;
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



#pragma mark ViewAction
-(IBAction)aa:(id)sender {
    if (animationbool) {
        NSValue * newframe = [NSValue valueWithCGRect:CGRectMake(0, 500, 0, 0)];
        [self spring:newframe];
        animationbool = NO;
    }else {
        [self spring:oldframe];
        animationbool = YES;
    }
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
