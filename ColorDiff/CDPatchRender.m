//
//  CDPatchRender.m
//  ColorDiff
//
//  Created by Jiejing Zhang on 12-10-18.
//  Copyright (c) 2012年 Jiejing Zhang. All rights reserved.
//

#import "CDPatchRender.h"

@implementation CDPatchRender

@synthesize theme;

- (id) init
{
    self = [super init];
    return self;
}

- (void)renderText:(NSMutableAttributedString *)text type:(NSString *)type
{
    if ([type isEqualToString:@"diffu"]) {
        [self renderTextUnifyDiff:text];
    } else if ([type isEqualToString:@"git"]) {
        [self renderTextUnifyDiff:text];
    } else {
        NSAssert(false, @"not support format");
    }
}

typedef enum DiffLineType {
    LINE_TYPE_ADD = 1,
    LINE_TYPE_DEL,
    LINE_TYPE_STUFF,
    LINE_TYPE_TOOL_STUFF,  // stuff line generate by CVS or git or SVN...
    LINE_TYPE_PLAIN_TEXT,
} DiffLineType;
    

- (DiffLineType)unifyDiffGetStringType:(NSString *) string range:(NSRange) range
{
    
    NSError *error = NULL;
    NSRegularExpression *delpred = [NSRegularExpression regularExpressionWithPattern:@"^\\-"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSRegularExpression *addpred = [NSRegularExpression regularExpressionWithPattern:@"^\\+"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];

    NSRegularExpression *diffstuffpred = [NSRegularExpression regularExpressionWithPattern:@"^\\@"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];

    NSRegularExpression *diffstuff2pred = [NSRegularExpression regularExpressionWithPattern:@"^Only in"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];

    NSRegularExpression *cvsstuffpred = [NSRegularExpression regularExpressionWithPattern:@"^(Index: |={4,}|RCS file: |retrieving |diff |index |-{3,} |\\+\\+\\+)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];

    if ([cvsstuffpred numberOfMatchesInString:string options:0 range:range] > 0)
        return LINE_TYPE_TOOL_STUFF;
    else if ([diffstuff2pred numberOfMatchesInString:string options:0 range:range] > 0)
        return LINE_TYPE_STUFF;
    else if ([diffstuffpred numberOfMatchesInString:string options:0 range:range] > 0)
        return LINE_TYPE_STUFF;
    else if ([addpred numberOfMatchesInString:string options:0 range:range] > 0)
        return LINE_TYPE_ADD;
    else if ([delpred numberOfMatchesInString:string options:0 range:range] > 0)
        return LINE_TYPE_DEL;
    else
        return LINE_TYPE_PLAIN_TEXT;
}

// format: diff -u or git diff or git format-patch.
- (void)renderTextUnifyDiff: (NSMutableAttributedString *)text
{
    unsigned length = [text length];
    unsigned paraStart = 0, paraEnd = 0, contentsEnd = 0;
    NSRange currentRange;
    [text beginEditing];
    while (paraEnd < length) {
        [text.string getParagraphStart:&paraStart end:&paraEnd
                      contentsEnd:&contentsEnd forRange:NSMakeRange(paraEnd, 0)];
        currentRange = NSMakeRange(paraStart, contentsEnd - paraStart);
        
        DiffLineType type = [self unifyDiffGetStringType:text.string range:currentRange];
        [self renderTextWithAttribute:text range:currentRange type:type];
    }
    [text endEditing];
}

- (void) renderTextWithAttribute:(NSMutableAttributedString *) text range:(NSRange) range type:(DiffLineType) type
{
    UIColor *textColor;
    UIFont  *textFont;
    
    textFont = [UIFont fontWithName:@"HelveticaNeue" size: [UIFont systemFontSize]];
    
    if (self.theme == COLOR_TEXT_THEME_DAY) {
        switch (type) {
            case LINE_TYPE_ADD:
                textColor = [UIColor colorWithRed:0.0 green:.73f blue:0.36f alpha:1.0f];
                break;
            case LINE_TYPE_DEL:
                textColor = [UIColor colorWithRed:0.80f green:0.2f blue:0.156f alpha:1.0f];
                break;
            case LINE_TYPE_STUFF:
                textColor = [UIColor colorWithRed:0.08f green:0.733f blue:0.78f alpha:1.0f];
                break;
            case LINE_TYPE_TOOL_STUFF:
                textColor = [UIColor blackColor];
                textFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:[UIFont systemFontSize]];
                break;
            default:
                textColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:1];
        };
        
        NSDictionary* style = @{
            NSForegroundColorAttributeName: textColor,
            NSFontAttributeName: textFont,
        };
        [text addAttributes:style range:range];
        
        
    } else if (self.theme == COLOR_TEXT_THEME_NIGHT) {
        NSAssert(false, @"needs to implement");
    }
}

@end
