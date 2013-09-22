//
//  MCFontMapLabel.m
//  MissleCommand
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//

#import "MCFontMapLabel.h"

@implementation MCFontMapLabel

-(NSDictionary*)createSpritesFromChars:(NSArray*)chars fontSize:(float)size
{
    
    NSDictionary * fontInfoDict = [self.font fontInformationDictionary];
    float lh = [[fontInfoDict objectForKey:@"lineHeight"]floatValue];
    float fps = [[fontInfoDict objectForKey:@"size"]floatValue];
    
    float lineHeight = size/lh;
    float fontPixelSize = size/fps;
    
    
    NSMutableArray * m = [[NSMutableArray alloc]init];
    NSMutableDictionary * returnDict = [[NSMutableDictionary alloc]init];
    [returnDict setObject:m forKey:@"Sprites"];
    [returnDict setObject:[NSNumber numberWithFloat:fps] forKey:@"Font Pixel Size"];
    [returnDict setObject:[NSNumber numberWithFloat:lh] forKey:@"Line Height"];
    [returnDict setObject:[NSNumber numberWithFloat:fontPixelSize] forKey:@"Scale"];
    NSDictionary * space = [self.font dictionaryForCharacter:@" "];
    float spaceSize = [[space objectForKey:@"xadvance"]floatValue];
    [returnDict setObject:[NSNumber numberWithFloat:spaceSize] forKey:@"Space Size"];
    
    float totalWidth=0;
    float addSpace = [[returnDict objectForKey:@"Space Size"]floatValue];
    
    for (NSString*ch in chars) {
        NSDictionary * chr = [self.font dictionaryForCharacter:ch];
        SKTexture * spTexture = [SKTexture textureWithImage:[chr objectForKey:@"Image"]];
        float w=0,h=0;
        w = [[chr objectForKey:@"width"]floatValue];
        h = [[chr objectForKey:@"height"]floatValue];
        if(w <=0){
            w =(addSpace);
            totalWidth +=(addSpace);
        }
        else{
            totalWidth +=[[chr objectForKey:@"xadvance"]floatValue];
        }
        if(h <=0)h=lineHeight;
        
        SKSpriteNode * sprite = [[SKSpriteNode alloc]initWithTexture:spTexture color:nil size:CGSizeMake(w, h)];
        sprite.color = [chr objectForKey:@"Color"];
        sprite.colorBlendFactor = [[chr objectForKey:@"Blend"]floatValue];
        sprite.xScale = fontPixelSize;
        sprite.yScale = fontPixelSize;
        lineHeight *=lineHeight;
        float spAdvance = [[chr objectForKey:@"xadvance"]floatValue];
        float xOffset,yOffset;
        xOffset = [[chr objectForKey:@"xoffset"]floatValue];
        yOffset = [[chr objectForKey:@"yoffset"]floatValue];
        NSDictionary * spriteDict = [NSDictionary dictionaryWithObjectsAndKeys:sprite,@"Sprite",[NSNumber numberWithFloat:spAdvance],@"xadvance",[NSNumber numberWithFloat:xOffset],@"xOffset",
                                     [NSNumber numberWithFloat:yOffset],@"yOffset",[chr objectForKey:@"id"],@"id",nil];
        
        sprite.name = ch;
        sprite.anchorPoint = CGPointMake(0,.5);
        [m addObject:spriteDict];
    }

    [returnDict setObject:[NSNumber numberWithFloat:totalWidth] forKey:@"Total Width"];
    
    return returnDict;
}


-(id)initWithString:(NSString*)string font:(MCFont*)font fontSize:(float)size maxWidth:(float)maxWidth
{
    
    if(self=[super init]){
        self.font = font;
        self.fontSize = size;
        self.string = string;
        self.anchorPoint = CGPointMake(.5, .5);
        int i =0;
        NSMutableArray * chars = [[NSMutableArray alloc]init];
        while (i < string.length) {
            
            NSString * c = [NSString stringWithFormat:@"%c",[string characterAtIndex:i]];
            
            [chars addObject:c];
            i++;
        }
        NSDictionary * sprites = [self createSpritesFromChars:chars fontSize:size];

        float scale = [[sprites objectForKey:@"Scale"]floatValue];
        float xpoint=0;
        
        float labelHeight =([[sprites objectForKey:@"Line Height"]floatValue])*scale;
        float labelWidth =([[sprites objectForKey:@"Total Width"]floatValue]+[[sprites objectForKey:@"Space Size"]floatValue])*scale;
        
        xpoint -= (labelWidth/2)-(([[sprites objectForKey:@"Space Size"]floatValue]*scale)/2);

        
        if(maxWidth ==0){
            self.size = CGSizeMake(labelWidth,labelHeight);
            int index=0;
            for (NSDictionary * chr in [sprites objectForKey:@"Sprites"]) {
                
                SKSpriteNode * theSprite = [chr objectForKey:@"Sprite"];
                
                char nextChar,lastChar;
                int kern=0;
                
                if((index+1 != string.length) && index){
                     lastChar = [string characterAtIndex:index];
                    nextChar = [string characterAtIndex:index+1];
                    kern = [font kerningForFirst:[NSString stringWithFormat:@"%c",lastChar] second:[NSString stringWithFormat:@"%c",nextChar]];
                }
                CGPoint pos =CGPointMake((xpoint+(kern))-(([[chr objectForKey:@"xOffset"]floatValue]*theSprite.xScale)/2),
                                         CGRectGetMidX(self.frame)-(([[chr objectForKey:@"yOffset"]floatValue]*theSprite.yScale)/2));

                CGPoint sposition = pos;
                
                theSprite.position = sposition;
                if(![theSprite.name isEqualToString:@" "])xpoint += (([[chr objectForKey:@"xadvance"]floatValue])*theSprite.xScale);
                else{
                    int amt=0;
                    if(kern >0) amt =kern;
                    xpoint += ([[chr objectForKey:@"xadvance"]floatValue]*theSprite.xScale)+(([[chr objectForKey:@"xOffset"]floatValue]*theSprite.xScale)/2);
                }
                [self addChild:theSprite];
                
                index++;
            }
            
        }
        else{
            
            float totalWidth =[[sprites objectForKey:@"Total Width"]floatValue];
            int lineCount =1;
            if (totalWidth > maxWidth) {
                lineCount = totalWidth / maxWidth;
                if ((int)totalWidth%(int)maxWidth) {
                    lineCount ++;
                }
            }
            //Now we step through
            float scaleFactor = [[sprites objectForKey:@"Scale"]floatValue];
            float baseWidth = [[sprites objectForKey:@"Font Pixel Size"]floatValue]*scaleFactor;
            float thisLine =0;
            NSMutableArray * lines =[[NSMutableArray alloc]init];
            NSMutableArray * currentLine = [[NSMutableArray alloc]init];
            for (NSDictionary * sd in [sprites objectForKey:@"Sprites"]) {
                thisLine += ([[sd objectForKey:@"xadvance"]floatValue]*scaleFactor)+(([[sd objectForKey:@"xOffset"]floatValue]*scaleFactor)/2);
                if(thisLine >= maxWidth){

                }
            }
            
            NSLog(@"LineCount %i",lineCount);
        }
    }
    
    return self;
    
}

@end
