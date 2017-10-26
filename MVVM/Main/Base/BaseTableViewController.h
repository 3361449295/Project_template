//
//  BaseTableViewController.h
//  MVVM
//
//  Created by Arthur on 2017/10/20.
//  Copyright © 2017年 Arthur. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL needRefresh;

- (void)tableViewRegisterClass;

@end
