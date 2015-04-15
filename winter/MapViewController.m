//
//  MapViewController.m
//  winter
//
//  Created by command.Zi on 15/3/25.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MyService.h"
#import "MyModal.h"

@interface MapViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray * mutableArray;
    NSMutableArray * mutableArrayList;
    GuideModel * modal;

}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mutableArray = [NSMutableArray new];
    mutableArrayList = [NSMutableArray new];
    
    MyService * service = [[MyService alloc]init];
    [service getGuidesCategoryListWithHandler:^(BOOL state, id object, NSError *error) {
        if (state == YES) {
            mutableArray = object;
            [self.tableView reloadData];
        }
    }];
    
    [service getGuidesListWithCategoryId:1 limit:10 offset:0 handler:^(BOOL state, id object, NSError *error) {
        if (state == YES) {
            mutableArrayList = object;
            [self.tableView reloadData];
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mutableArrayList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    modal = (GuideModel *)mutableArrayList[indexPath.row];
    cell.textLabel.text = modal.guideTitle;
    cell.detailTextLabel.text = modal.guideTime;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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
