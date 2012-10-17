//
//  CDTextProcessor.h
//  ColorDiff
//
//  Created by Jiejing Zhang on 12-10-16.
//  Copyright (c) 2012年 Jiejing Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

enum CDTextColorTheme {
    COLOR_TEXT_THEME_DAY,
    COLOR_TEXT_THEME_NIGHT,
};

/**
 * This class is add the color attribute to the text passed in.
 * the color will added as the input theme parameter.
 * It was the main enter of ColorDiff Module.
 *
 */
@interface CDTextProcessor : UICollectionViewController

/**
 * This function is main enter of this class.
 * @attstring : the input mutable string.
 * @return: return the modified attribute string.
 */
- (NSMutableAttributedString *) processPatchText:(NSMutableAttributedString*) attstring withTheme:(int) theme suggestFormat:(NSString *) format;

@end
