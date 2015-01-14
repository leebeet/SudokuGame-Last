//
//  RootDynamicTableController.h
//  Sudoku
//
//  Created by whunf on 14-10-8.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "RootViewController.h"

@interface RootDynamicTableController : RootViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableItems;

@end
