//
//  ZZZViewController.m
//  winter
//
//  Created by command.Zi on 15/1/30.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "ZZZViewController.h"
#import "SaKuraScrollView.h"

@interface ZZZViewController () <SaKuraScrollViewDelegate>

@property (strong, nonatomic) IBOutlet SaKuraScrollView *myScrollView;
@property (strong, nonatomic) NSMutableArray * myMutableArray;

@end

@implementation ZZZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myMutableArray = [[NSMutableArray alloc]init];
    
    UIImage * img = [UIImage imageNamed:@"1.jpg"];
    UIImage * img1 = [UIImage imageNamed:@"2.png"];
    UIImage * img2 = [UIImage imageNamed:@"3.png"];
    UIImage * img3 = [UIImage imageNamed:@"2.png"];
    UIImage * img4 = [UIImage imageNamed:@"1.jpg"];
    UIImage * img5 = [UIImage imageNamed:@"2.png"];
    UIImage * img6 = [UIImage imageNamed:@"3.png"];
    
    [self.myMutableArray addObject:img];
    [self.myMutableArray addObject:img1];
    [self.myMutableArray addObject:img2];
    [self.myMutableArray addObject:img3];
    [self.myMutableArray addObject:img4];
    [self.myMutableArray addObject:img5];
    [self.myMutableArray addObject:img6];
    
    self.myScrollView.imagesMutableArray = self.myMutableArray;
    self.myScrollView.sakuraDelegate = self;

    
    SaKuraScrollView * cvView = [[SaKuraScrollView alloc]initWithFrame:CGRectMake(0, 300, 320, 200)];
    cvView.imagesMutableArray = self.myMutableArray;
    cvView.sakuraDelegate = self;
    [self.view addSubview:cvView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectPageAtScrollView:(UIScrollView *)SaKuraScrollView selectPage:(NSInteger)selectPage {
    switch (selectPage) {
        case 0:
            NSLog(@"000");
            break;
        case 1:
            NSLog(@"111");
            break;
        default:
            break;
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
