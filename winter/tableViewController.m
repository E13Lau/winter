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
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation tableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view.
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
    cell.textLabel.text = @"AAA";
    myAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    myAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(30, 0,320,44)];
    myAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0,320,44)];
    myAnimation.duration = 1.0f;
    [cell pop_addAnimation:myAnimation forKey:@"go"];
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
