//
//  ScrollViewViewController.m
//  winter
//
//  Created by command.Zi on 15/1/19.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "ScrollViewViewController.h"
#import <POP.h>

@interface ScrollViewViewController () <UIScrollViewDelegate> {
    NSValue * oldframe;
    BOOL animationbool;
}

@property (weak, nonatomic) IBOutlet UIScrollView *myscroll;
@property (nonatomic, strong)NSArray *imgarr;
@end

@implementation ScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myscroll.pagingEnabled = YES;
    _myscroll.backgroundColor = [UIColor clearColor];
    _imgarr = @[@"3.png",@"0.jpg", @"1.jpg", @"2.png", @"3.png",@"0.jpg"];
    _myscroll.contentSize = CGSizeMake(_imgarr.count*320, 200);
    for (int i = 0; i<_imgarr.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 200)];
        img.image = [UIImage imageNamed:_imgarr[i]];
        [_myscroll addSubview:img];
    }
    _myscroll.delegate = self;
    
    oldframe = [NSValue valueWithCGRect:CGRectMake(0, 0, 320, 200)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x <=0) {
        CGPoint abc = CGPointMake(320*(_imgarr.count-2), 0);
        [scrollView setContentOffset:abc animated:NO];
    }if (scrollView.contentOffset.x>=(_imgarr.count-1)*320) {
        CGPoint abc = CGPointMake(320, 0);
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
