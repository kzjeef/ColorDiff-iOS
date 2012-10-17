//
//  CDTextProcessor.m
//  ColorDiff
//
//  Created by Jiejing Zhang on 12-10-16.
//  Copyright (c) 2012年 Jiejing Zhang. All rights reserved.
//

#import "CDTextProcessor.h"

@implementation CDTextProcessor


// This function should first detech which patch format of this, the
// git format-patch or something like svn or raw diff output.
//
// then it should call the different render to do the actually render job.
- (NSMutableAttributedString *) processPatchText:(NSMutableAttributedString*) attstring withTheme: (int) theme suggestFormat:(NSString *) format
{
    
}

@end
