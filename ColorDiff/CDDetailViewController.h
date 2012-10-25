//
//  CDDetailViewController.h
//  ColorDiff
//
//  Created by Jiejing Zhang on 12-10-14.
//  Copyright (c) 2012年 Jiejing Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CDOpenNewDocumentNotify @"Open New Document"

@interface CDDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *isBusying;


@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
- (IBAction)ColorIconClicked:(id)sender;
@end
