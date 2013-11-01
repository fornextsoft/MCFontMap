//
//  MCFontManager.m
//  MCFontMap
//
//  Created by April Gendill on 11/1/13.
//  Copyright (c) 2013 April Gendill. All rights reserved.
//

#import "MCFontManager.h"
#import "MCFont.h"


MCFontManager * fontManager;

@implementation MCFontManager


-(id)init
{
    if(self = [super init]){
        loadedFonts = [[NSMutableDictionary alloc]init];
    }
    
    return self;
}

+(instancetype)fontManager
{
    if(!fontManager){
        fontManager = [[MCFontManager alloc]init];
    }
    
    return fontManager;
}


-(MCFont*)fontNamed:(NSString *)name isXML:(BOOL)xml
{
    //Load fonts once. Keep them.
    if(![loadedFonts objectForKey:[name stringByDeletingPathExtension]]){
        MCFont * newFont = [[MCFont alloc]initWithFontNamed:name isXML:xml];
        [loadedFonts setObject:newFont forKey:[name stringByDeletingPathExtension]];
    }
    
    return [loadedFonts objectForKey:[name stringByDeletingPathExtension]];
}

-(void)disposeFontNamed:(NSString*)name
{
    [loadedFonts removeObjectForKey:[name stringByDeletingPathExtension]];
}

@end
