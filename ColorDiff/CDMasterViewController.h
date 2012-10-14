//
//  CDMasterViewController.h
//  ColorDiff
//
//  Created by Jiejing Zhang on 12-10-14.
//  Copyright (c) 2012年 Jiejing Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDDetailViewController;

@interface CDMasterViewController : UITableViewController

@property (strong, nonatomic) CDDetailViewController *detailViewController;

@end
