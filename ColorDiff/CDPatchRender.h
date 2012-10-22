//
//  CDPatchRender.h
//  ColorDiff
//
//  Created by Jiejing Zhang on 12-10-18.
//  Copyright (c) 2012年 Jiejing Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CDTextProcessor.h"
/*
 * This class mainly focus on convert stuff of patch color render with given type of text.
 */
@interface CDPatchRender : NSObject
{
    CDTextColorTheme _theme;
}

// Theme of the render, like day(white) or night(black) mode.
@property CDTextColorTheme theme;

- (void) renderText:(NSMutableAttributedString *) text type:(NSString *) type;

@end
