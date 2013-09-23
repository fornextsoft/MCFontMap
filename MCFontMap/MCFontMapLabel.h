//
//  MCFontMapLabel.h
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "MCFont.h"
#import "MCFontMapReader.h"

/*
 As a subclass of SKSpriteNode MCFontMapLabel responds to all of the standard SKSpriteNode selectors.
*/

@interface MCFontMapLabel : SKSpriteNode
{
    float width;
    float height;
    
}


@property (nonatomic,strong) MCFont * font;
@property (nonatomic,strong) NSString * string;
@property (nonatomic) float fontSize;

//Create a label with a fontmapped font, multiple line labels are only supported by \n delimitation

//Multiple lines do not currently support scrolling so keep labels screen size or smaller.

-(id)initWithString:(NSString*)string font:(MCFont*)font fontSize:(float)size;




@end
