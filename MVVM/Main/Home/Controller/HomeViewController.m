//
//  HomeViewController.m
//  MVVM
//
//  Created by Arthur on 2017/10/20.
//  Copyright © 2017年 Arthur. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeTableViewCell.h"
@interface HomeViewController () <ImageClickDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation HomeViewController {
    NSString *_indetity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
    [self dataAccess];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indetity forIndexPath:indexPath];
    cell.delegate = self;
    cell.clickBlock = ^(NSString *title) {
        NSLog(@"%@",title);
    };
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)imageClickAction:(NSString *)imagePath {
    NSLog(@"%@",imagePath);
}

- (void)setupView {
    self.tableView.frame = self.view.bounds;
    self.tableView.rowHeight = 140;
    [self.view addSubview:self.tableView];
}

- (void)dataAccess {
    WS(weakself);
    self.dataArr = @[].mutableCopy;
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel handleDataWithSuccess:^(NSArray *arr) {
        [weakself.dataArr addObjectsFromArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)tableViewRegisterClass {
    _indetity = @"home_cell";
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:_indetity];
}


@end
