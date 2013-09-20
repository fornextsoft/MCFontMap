//
//  MCFont.m
//  MissleCommand
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//

#import "MCFont.h"

@implementation MCFont


-(id)initWithFontNamed:(NSString*)fontName isXML:(BOOL)xml
{
    if(self=[super init]){
        
        if(![fontName pathExtension]){
            fontName = [[NSString stringWithFormat:@"%@.fntpkg",fontName]lastPathComponent];
        }
        
        reader = [[MCFontMapReader alloc]initWithFontPackageNamed:fontName isXML:xml];
    }
    
    return self;
}


-(NSDictionary*)fontInformationDictionary
{
    return reader.fontData;
}


-(NSDictionary*)dictionaryForCharacter:(NSString *)ch
{
    return [reader.fontDict objectForKey:ch];
}



-(NSString*)description
{
    NSString *p1 = [super description];
    NSString * charCount = [NSString stringWithFormat:@"%i",reader.fontDict.count];
    NSString * fontName = [NSString stringWithFormat:@"%@",[reader.fontData objectForKey:@"face"]];
    NSString * image = [NSString stringWithFormat:@"%@",[reader.fontData objectForKey:@"file"]];
    NSString * b=@"NO",*i=@"NO";
    if([[reader.fontData objectForKey:@"bold"]boolValue]){
        b=@"YES";
    }
    if ([[reader.fontData objectForKey:@"italic"]boolValue]) {
        i=@"YES";
    }
    NSString * attrib = [NSString stringWithFormat:@"Attributes: Bold : %@, Italic : %@",b,i];
    NSString * rtString =[NSString stringWithFormat:@"<%@ 0x%x> Name: \"%@\" | Image: \"%@\" | %@ | Char count = %@",self.class,self,fontName,image,attrib,charCount];
    return rtString;
}

@end
