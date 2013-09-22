//
//  MCFont.h
//  MissleCommand
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCFontMapReader.h"

@interface MCFont : NSObject
{
    MCFontMapReader * reader;
    UIColor *_fontColor;
    float _fontColorBlend;
}

@property (nonatomic) BOOL kern; //Defaults to YES
@property (nonatomic,strong) UIColor* fontColor;
@property (nonatomic) float fontColorBlend;

-(id)initWithFontNamed:(NSString*)fontName isXML:(BOOL)xml;

-(NSDictionary*)dictionaryForCharacter:(NSString*)ch;
-(NSDictionary*)fontInformationDictionary;
-(int)kerningForFirst:(NSString*)first second:(NSString*)second;

@end
