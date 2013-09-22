//
//  MCFont.m
//  MissleCommand
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//

#import "MCFont.h"

float getXRelevantToWidth(float width,float xPos)
{

    return (width/2)+(xPos/1.338);
}

float getYRelevantToHeight(float height,float yPos)
{
    
    return (height*2.70)+(yPos/1.25);
}


@implementation MCFont


-(id)initWithFontNamed:(NSString*)fontName isXML:(BOOL)xml
{
    if(self=[super init]){
        
        if(![fontName pathExtension]){
            fontName = [[NSString stringWithFormat:@"%@.fntpkg",fontName]lastPathComponent];
        }
        
        reader = [[MCFontMapReader alloc]initWithFontPackageNamed:fontName isXML:xml];
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
    self.fontColor = self.fontColor;
}

-(float)fontColorBlend
{
    return _fontColorBlend;
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
