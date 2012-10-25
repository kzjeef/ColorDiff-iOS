//
//  CDDetailViewController.m
//  ColorDiff
//
//  Created by Jiejing Zhang on 12-10-14.
//  Copyright (c) 2012年 Jiejing Zhang. All rights reserved.
//

#import "CDDetailViewController.h"
#import "CDTextProcessor.h"

@interface CDDetailViewController ()
{
    CDTextProcessor *processor;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation CDDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)openApplicationWithURL:(NSNotification *)notification
{
    NSURL *url;
    
    url = [notification object];
    
    if ([url isKindOfClass:[NSURL class ]] && [url isFileURL]) {
        
        self.textView.attributedText = nil;
        self.textView.text = nil;
        
        self.isBusying.hidden = NO;
        [self.isBusying startAnimating];
        
        dispatch_async(dispatch_queue_create("patch process", nil), ^() {
            NSError *error;
            NSString *text = [NSString stringWithContentsOfURL:url encoding:NSStringEncodingConversionAllowLossy error:&error];
            
            if (error) {
                NSLog(@"error when open url:%@", url);
                [self.isBusying stopAnimating];
                // TODO: add some error alert here.
                return;
            }
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
            
            // FIXME: use auto detect format.
            [processor processPatchText:str withTheme:COLOR_TEXT_THEME_DAY suggestFormat:@"diffu"];
            
            dispatch_async(dispatch_get_main_queue(), ^() {
                [self.isBusying stopAnimating];
                self.textView.attributedText = str;
            });
        });
        // open set the content to this.
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    processor = [[CDTextProcessor alloc] init];
    
    NSLog(@"Detail View Controller did load");

    [self configureView];
    
    NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(openApplicationWithURL:)
                name:CDOpenNewDocumentNotify
              object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)ColorIconClicked:(id)sender {
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc
                                       ] initWithString:self.textView.text];
    [self.textView setEditable:YES];
    

    [processor processPatchText:str withTheme:COLOR_TEXT_THEME_DAY suggestFormat:@"diffu"];

    [self.textView setAttributedText:str];

    NSLog(@"|||||||||||||||||||||||||||||||||");
    
    NSLog(@"STD: %@", str);
    NSLog(@"-----------------------------");
    NSLog(@"%@", self.textView.attributedText);
    

}
@end
