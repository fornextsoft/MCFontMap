//
//  MCFontMapLabel.h
//  MissleCommand
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#import "MCFont.h"
#import "MCFontMapReader.h"



@interface MCFontMapLabel : SKSpriteNode
{
    float width;
    float height;
    
}


@property (nonatomic,strong) MCFont * font;
@property (nonatomic,strong) NSString * string;
@property (nonatomic) float fontSize;

//Create a label with a fontmapped font, with a mximum width of maxWidth. for a single line label with no maximum width set maxWidth =0
-(id)initWithString:(NSString*)string font:(MCFont*)font fontSize:(float)size maxWidth:(float)maxWidth;




@end
