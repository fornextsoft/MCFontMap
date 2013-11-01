//
//  MCFontManager.h
//  MCFontMap
//
//  Created by April Gendill on 11/1/13.
//  Copyright (c) 2013 April Gendill. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MCFont;

@interface MCFontManager : NSObject
{
    NSMutableDictionary * loadedFonts;
}

+(instancetype)fontManager;

-(MCFont*)fontNamed:(NSString *)name isXML:(BOOL)xml;

@end
