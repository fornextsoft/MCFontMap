//
//  MCFont.h
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MCFontMapReader.h"

#ifdef MACOS
#define UIColor NSColor
#endif

@interface MCFont : NSObject
{
    MCFontMapReader * reader;
    SKColor *_fontColor;
    float _fontColorBlend;
}

@property (nonatomic) BOOL kern; //Defaults to YES
@property (nonatomic,strong) SKColor* fontColor;
@property (nonatomic) float fontColorBlend;


/*
 MCFontMap requires font's to be placed in a folder with the extension .fntpkg
 The png and fnt file must have the same name as the folder they are in so:
 
 MyFont.fntpkg
    MyFont.fnt
    MyFont.png
 */

-(id)initWithFontNamed:(NSString*)fontName isXML:(BOOL)xml;

//Pass the character in string form and get back it's dictionary
-(NSDictionary*)dictionaryForCharacter:(NSString*)ch;

//The global information for the font such as line height
-(NSDictionary*)fontInformationDictionary;

//Pass in the current character and the one that will follow it to get the kerning for that character set
//This might not be the standard way of doing this, but I'm not a font expert and never worked with fonts at this level before
-(int)kerningForFirst:(NSString*)first second:(NSString*)second;

@end
