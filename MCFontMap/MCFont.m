//
//  MCFont.m
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
        //Init the font reader and have it read the font map
        //We don't actually need the XML variable to be accurate, since the reader performs a check
        reader = [[MCFontMapReader alloc]initWithFontPackageNamed:fontName isXML:xml];
        //Assume that kerning is supported by this font
        self.kern = YES;
        self.fontColor = [UIColor clearColor];
        self.fontColorBlend =0;
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

-(int)kerningForFirst:(NSString*)first second:(NSString*)second;
{
    if(!self.kern) return 0;
    //The kerning support is completely lifted from Cocos2D's kerning support So if a particular kern did not work in Cocos2D it's won't wokr here either
    char fk =[first characterAtIndex:0];
    char lk = [second characterAtIndex:0];
    int kv =(fk<<16) | (lk&0xffff);
    
    NSString * key = [NSString stringWithFormat:@"%i",kv];
    
    NSNumber * amount = [reader.kerningDict objectForKey:key];
    
    return [amount intValue];
    
}


-(void)setFontColor:(UIColor *)fontColor
{
    _fontColor = fontColor;

    for (NSString*sp in reader.fontDict) {
        //We have to actually step through each character and set it's color
        [reader setValue:fontColor forKey:@"Color" forCharacter:sp];
        [reader setValue:[NSNumber numberWithFloat:self.fontColorBlend] forKey:@"Blend" forCharacter:sp];
    }
}

-(UIColor*)fontColor
{
    return _fontColor;
}

-(void)setFontColorBlend:(float)fontColorBlend
{
    _fontColorBlend = fontColorBlend;
    //Belnd is changed so we have to set all the info in the sprite list.
    self.fontColor = self.fontColor;
}

-(float)fontColorBlend
{
    return _fontColorBlend;
}

-(NSString*)description
{
    //I like to do this with custom objects so I can have some finite details
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
