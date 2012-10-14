//
//  CDDetailViewController.h
//  ColorDiff
//
//  Created by Jiejing Zhang on 12-10-14.
//  Copyright (c) 2012年 Jiejing Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
