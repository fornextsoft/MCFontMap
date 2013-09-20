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
    
}



-(id)initWithFontNamed:(NSString*)fontName isXML:(BOOL)xml;

-(NSDictionary*)dictionaryForCharacter:(NSString*)ch;
-(NSDictionary*)fontInformationDictionary;

@end
