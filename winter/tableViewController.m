//
//  tableViewController.m
//  winter
//
//  Created by command.Zi on 15/1/20.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "tableViewController.h"
#import <POP.h>

@interface tableViewController () {
    POPBasicAnimation * myAnimation;
//    NSMutableAttributedString * string;
//    CATextLayer *textLayer;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation tableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    string = [[NSMutableAttributedString alloc]initWithString:@"AAAA"];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
//    textLayer = [CATextLayer layer];
//    textLayer.string = string;
//    textLayer.frame = CGRectMake(0, 0, 100, 100);
//    textLayer.contentsScale = [UIScreen mainScreen].scale;
    //    [self.view.layer addSublayer:textLayer];
    //    cell.textLabel.text = string;

    // Do any additional setup after loading the view.
}

- (CALayer *)getTextLayerWithFrame:(CGRect)frame String:(NSString *)string {
    CALayer * backLayer = [CALayer layer];
    backLayer.frame = frame;
    
//    NSMutableAttributedString * myString = [[NSMutableAttributedString alloc]initWithString:string];
//    [myString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
//    
//    CATextLayer * stringLayer = [CATextLayer layer];
//    stringLayer.string = myString;
//    stringLayer.frame = CGRectMake(frame.size.width*0.2, 0, frame.size.width*0.8, frame.size.height);
//    stringLayer.contentsScale = [UIScreen mainScreen].scale;
    [backLayer addSublayer:[self getColorLayer]];
    [backLayer addSublayer:[self getTextLayerWithString:@"AAAAAAA"]];
    return backLayer;
}

- (CALayer *)getTextLayerWithString:(NSString *)stirng {
    NSMutableAttributedString * myString = [[NSMutableAttributedString alloc]initWithString:stirng];
    [myString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 1)];
    
    UILabel * lage = [[UILabel alloc]init];
    lage.attributedText = myString;
    CATextLayer * textLayer = [CATextLayer layer];
    textLayer.string = myString;
    textLayer.frame = CGRectMake(25, 12.5, 43, 43);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    return textLayer;
}

- (CALayer *)getColorLayer {
    UIBezierPath * path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addArcWithCenter:CGPointMake(21.5, 21.5) radius:21.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer * colorLayer = [CAShapeLayer layer];
    colorLayer.fillColor = [UIColor redColor].CGColor;
    colorLayer.path = path.CGPath;
    colorLayer.contentsScale = [UIScreen mainScreen].scale;
    return colorLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableAttributedString * myString = [[NSMutableAttributedString alloc]initWithString:@"AAAAA"];
    [myString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 1)];
    cell.textLabel.attributedText = myString;
    cell.backgroundColor = [UIColor clearColor];
    [cell.layer insertSublayer:[self getColorLayer] atIndex:0];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 配置CATransform3D的内容
    CATransform3D transform;
    transform = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    transform.m34 = 1.0/ -600;
    
    // 2. 定义cell的初始状态
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = transform;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    // 3. 定义cell的最终状态，并提交动画
    [UIView beginAnimations:@"transform" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView commitAnimations];

//    myAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
//    myAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, -300,cell.frame.size.width,cell.frame.size.height)];
//    myAnimation.toValue	 = [NSValue valueWithCGRect:cell.frame];
//    myAnimation.duration = 0.3f;
//    [cell pop_addAnimation:myAnimation forKey:@"go"];
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
