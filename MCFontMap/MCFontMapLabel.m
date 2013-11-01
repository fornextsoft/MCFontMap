//
//  MCFontMapLabel.m
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//

#import "MCFontMapLabel.h"

@implementation MCFontMapLabel

@synthesize string = _string;
@synthesize fontSize = _fontSize;

/*
 -(NSDictionary*)createSpritesFromChars:(NSArray*)chars fontSize:(float)size
 {
 
 NSDictionary * fontInfoDict = [self.font fontInformationDictionary];
 float lh = [[fontInfoDict objectForKey:@"lineHeight"]floatValue];
 float fps = [[fontInfoDict objectForKey:@"size"]floatValue];
 
 float lineHeight = size/lh;
 float fontPixelSize = size/fps;
 
 
 NSMutableArray * m = [[NSMutableArray alloc]init];
 NSMutableDictionary * returnDict = [[NSMutableDictionary alloc]init];
 //Create our dictionary of sprites
 [returnDict setObject:m forKey:@"Sprites"];
 //These are raw values, the scale will allow us to position everything correctly when we build the label
 [returnDict setObject:[NSNumber numberWithFloat:fps] forKey:@"Font Pixel Size"];
 [returnDict setObject:[NSNumber numberWithFloat:lh] forKey:@"Line Height"];
 [returnDict setObject:[NSNumber numberWithFloat:fontPixelSize] forKey:@"Scale"];
 NSDictionary * space = [self.font dictionaryForCharacter:@" "];
 //Each font's space xadvance is different and spaces are usually 0x0 pixels so we fake a space with a 1px height and the spaceSie for it's width
 float spaceSize = [[space objectForKey:@"xadvance"]floatValue];
 [returnDict setObject:[NSNumber numberWithFloat:spaceSize] forKey:@"Space Size"];
 
 float totalWidth=0;
 //Add the Space size to the dictionary
 float addSpace = [[returnDict objectForKey:@"Space Size"]floatValue];
 
 for (NSString*ch in chars) {
 //MCFont will return a character dictionary if we just pass a string with the given character
 NSDictionary * chr = [self.font dictionaryForCharacter:ch];
 //If we get a null return, we'll just stick a space in that spot... It was that or bail
 if(!chr) chr = [self.font dictionaryForCharacter:@" "];
 SKTexture * spTexture = [SKTexture textureWithImage:[chr objectForKey:@"Image"]];
 float w=0,h=0;
 w = [[chr objectForKey:@"width"]floatValue];
 h = [[chr objectForKey:@"height"]floatValue];
 if(w <=0){
 w =(addSpace);
 totalWidth +=(addSpace);
 }
 else{
 totalWidth +=([[chr objectForKey:@"xadvance"]floatValue]-[[chr objectForKey:@"xoffset"]floatValue]);
 }
 if(h <=0)h=lineHeight;
 
 MCLetterSprite * sprite = [[MCLetterSprite alloc]initWithTexture:spTexture color:nil size:CGSizeMake(w, h)];
 sprite.movable = NO;
 sprite.passThrough = YES;
 sprite.color = [chr objectForKey:@"Color"];
 sprite.colorBlendFactor = [[chr objectForKey:@"Blend"]floatValue];
 sprite.xScale = fontPixelSize;
 sprite.yScale = fontPixelSize;
 lineHeight *=lineHeight;
 float spAdvance = [[chr objectForKey:@"xadvance"]floatValue];
 float xOffset,yOffset;
 xOffset = [[chr objectForKey:@"xoffset"]floatValue];
 yOffset = [[chr objectForKey:@"yoffset"]floatValue];
 //Finally create the actual dictionary for the specific sprite
 NSDictionary * spriteDict = [NSDictionary dictionaryWithObjectsAndKeys:sprite,@"Sprite",[NSNumber numberWithFloat:spAdvance],@"xadvance",[NSNumber numberWithFloat:xOffset],@"xOffset",
 [NSNumber numberWithFloat:yOffset],@"yOffset",[chr objectForKey:@"id"],@"id",nil];
 
 sprite.name = ch;
 sprite.anchorPoint = CGPointMake(0,.5);
 [m addObject:spriteDict];
 }
 //Total width is only needed for single line labels, but it's returned always
 [returnDict setObject:[NSNumber numberWithFloat:totalWidth] forKey:@"Total Width"];
 
 return returnDict;
 }*/

-(NSDictionary*)getSpritesFromString:(NSString*)string fontSize:(float)size
{
    
    NSDictionary * fontInfoDict = [self.font fontInformationDictionary];
    float lh = [[fontInfoDict objectForKey:@"lineHeight"]floatValue];
    float fps = [[fontInfoDict objectForKey:@"size"]floatValue];
    
    float lineHeight = size/lh;
    float fontPixelSize = size/fps;
    
    
    NSMutableArray * m = [[NSMutableArray alloc]init];
    NSMutableDictionary * returnDict = [[NSMutableDictionary alloc]init];
    //Create our dictionary of sprites
    [returnDict setObject:m forKey:@"Sprites"];
    //These are raw values, the scale will allow us to position everything correctly when we build the label
    [returnDict setObject:[NSNumber numberWithFloat:fps] forKey:@"Font Pixel Size"];
    [returnDict setObject:[NSNumber numberWithFloat:lh] forKey:@"Line Height"];
    [returnDict setObject:[NSNumber numberWithFloat:fontPixelSize] forKey:@"Scale"];
    NSDictionary * space = [self.font dictionaryForCharacter:@" "];
    //Each font's space xadvance is different and spaces are usually 0x0 pixels so we fake a space with a 1px height and the spaceSie for it's width
    float spaceSize = [[space objectForKey:@"xadvance"]floatValue];
    [returnDict setObject:[NSNumber numberWithFloat:spaceSize] forKey:@"Space Size"];
    
    float totalWidth=0;
    //Add the Space size to the dictionary
    float addSpace = [[returnDict objectForKey:@"Space Size"]floatValue];
    for (int i=0; i < string.length; i++) {
        NSString * ch = [string substringWithRange:NSMakeRange(i, 1)];
        
        //MCFont will return a character dictionary if we just pass a string with the given character
        NSDictionary * chr = [self.font dictionaryForCharacter:ch];
        //If we get a null return, we'll just stick a space in that spot... It was that or bail
        if(!chr) chr = [self.font dictionaryForCharacter:@" "];
        
        float w=0,h=0;
        w = [[chr objectForKey:@"width"]floatValue];
        h = [[chr objectForKey:@"height"]floatValue];
        if(w <=0){
            w =(addSpace);
            totalWidth +=(addSpace);
        }
        else{
            totalWidth +=([[chr objectForKey:@"xadvance"]floatValue]-[[chr objectForKey:@"xoffset"]floatValue]);
        }
        if(h <=0)h=lineHeight;
        
        //MCLetterSprite * sprite = [[MCLetterSprite alloc]initWithTexture:[chr objectForKey:@"Image"] color:nil size:CGSizeMake(w, h)];
        
        MCLetterSprite * sprite = [(MCLetterSprite*)[chr objectForKey:@"Sprite"]copy];
        sprite.size = CGSizeMake(w, h);
        sprite.movable = NO;
        sprite.passThrough = YES;
        sprite.color = [chr objectForKey:@"Color"];
        sprite.colorBlendFactor = [[chr objectForKey:@"Blend"]floatValue];
        sprite.xScale = fontPixelSize;
        sprite.yScale = fontPixelSize;
        lineHeight *=lineHeight;
        float spAdvance = [[chr objectForKey:@"xadvance"]floatValue];
        float xOffset,yOffset;
        xOffset = [[chr objectForKey:@"xoffset"]floatValue];
        yOffset = [[chr objectForKey:@"yoffset"]floatValue];
        //Finally create the actual dictionary for the specific sprite
        NSDictionary * spriteDict = [NSDictionary dictionaryWithObjectsAndKeys:sprite,@"Sprite",[NSNumber numberWithFloat:spAdvance],@"xadvance",[NSNumber numberWithFloat:xOffset],@"xOffset",
                                     [NSNumber numberWithFloat:yOffset],@"yOffset",[chr objectForKey:@"id"],@"id",nil];
        
        sprite.name = ch;
        sprite.anchorPoint = CGPointMake(0,.5);
        [m addObject:spriteDict];
    }
    //Total width is only needed for single line labels, but it's returned always
    [returnDict setObject:[NSNumber numberWithFloat:totalWidth] forKey:@"Total Width"];
    
    return returnDict;
}

-(NSDictionary*)createSpritesFromString:(NSString*)string fontSize:(float)size
{
    
    NSDictionary * fontInfoDict = [self.font fontInformationDictionary];
    float lh = [[fontInfoDict objectForKey:@"lineHeight"]floatValue];
    float fps = [[fontInfoDict objectForKey:@"size"]floatValue];
    
    float lineHeight = size/lh;
    float fontPixelSize = size/fps;
    
    
    NSMutableArray * m = [[NSMutableArray alloc]init];
    NSMutableDictionary * returnDict = [[NSMutableDictionary alloc]init];
    //Create our dictionary of sprites
    [returnDict setObject:m forKey:@"Sprites"];
    //These are raw values, the scale will allow us to position everything correctly when we build the label
    [returnDict setObject:[NSNumber numberWithFloat:fps] forKey:@"Font Pixel Size"];
    [returnDict setObject:[NSNumber numberWithFloat:lh] forKey:@"Line Height"];
    [returnDict setObject:[NSNumber numberWithFloat:fontPixelSize] forKey:@"Scale"];
    NSDictionary * space = [self.font dictionaryForCharacter:@" "];
    //Each font's space xadvance is different and spaces are usually 0x0 pixels so we fake a space with a 1px height and the spaceSie for it's width
    float spaceSize = [[space objectForKey:@"xadvance"]floatValue];
    [returnDict setObject:[NSNumber numberWithFloat:spaceSize] forKey:@"Space Size"];
    
    float totalWidth=0;
    //Add the Space size to the dictionary
    float addSpace = [[returnDict objectForKey:@"Space Size"]floatValue];
    for (int i=0; i < string.length; i++) {
        NSString * ch = [string substringWithRange:NSMakeRange(i, 1)];
        
        //MCFont will return a character dictionary if we just pass a string with the given character
        NSDictionary * chr = [self.font dictionaryForCharacter:ch];
        //If we get a null return, we'll just stick a space in that spot... It was that or bail
        if(!chr) chr = [self.font dictionaryForCharacter:@" "];
        
        float w=0,h=0;
        w = [[chr objectForKey:@"width"]floatValue];
        h = [[chr objectForKey:@"height"]floatValue];
        if(w <=0){
            w =(addSpace);
            totalWidth +=(addSpace);
        }
        else{
            totalWidth +=([[chr objectForKey:@"xadvance"]floatValue]-[[chr objectForKey:@"xoffset"]floatValue]);
        }
        if(h <=0)h=lineHeight;
        
        MCLetterSprite * sprite = [[chr objectForKey:@"Sprite"]copy];// [[MCLetterSprite alloc]initWithTexture:[chr objectForKey:@"Image"] color:nil size:CGSizeMake(w, h)];
        sprite.size = CGSizeMake(w, h);
        sprite.movable = NO;
        sprite.passThrough = YES;
        sprite.color = [chr objectForKey:@"Color"];
        sprite.colorBlendFactor = [[chr objectForKey:@"Blend"]floatValue];
        sprite.xScale = fontPixelSize;
        sprite.yScale = fontPixelSize;
        lineHeight *=lineHeight;
        float spAdvance = [[chr objectForKey:@"xadvance"]floatValue];
        float xOffset,yOffset;
        xOffset = [[chr objectForKey:@"xoffset"]floatValue];
        yOffset = [[chr objectForKey:@"yoffset"]floatValue];
        //Finally create the actual dictionary for the specific sprite
        NSDictionary * spriteDict = [NSDictionary dictionaryWithObjectsAndKeys:sprite,@"Sprite",[NSNumber numberWithFloat:spAdvance],@"xadvance",[NSNumber numberWithFloat:xOffset],@"xOffset",
                                     [NSNumber numberWithFloat:yOffset],@"yOffset",[chr objectForKey:@"id"],@"id",nil];
        
        sprite.name = ch;
        sprite.anchorPoint = CGPointMake(0,.5);
        [m addObject:spriteDict];
    }
    //Total width is only needed for single line labels, but it's returned always
    [returnDict setObject:[NSNumber numberWithFloat:totalWidth] forKey:@"Total Width"];
    
    return returnDict;
}


-(id)initWithString:(NSString*)string font:(MCFont*)font fontSize:(float)size
{
    
    if(self=[super init]){
        
        self.font = font;
        self.fontSize = size; //These are reference variables in case I or you, need them at some point
        _string = [[NSString alloc]initWithString:string];
        self.movable = NO;
        self.passThrough = YES;
        self.anchorPoint = CGPointMake(.5, .5); //Should be already set to this but let's make sure.
        
        [self getSpritesFromString:string fontSize:14];
        
        //Create the sprite dictionary which contains all of the information about each sprite.
        NSDictionary * sprites = [self createSpritesFromString:string fontSize:size];
        //I have used setting the color to mark the bounding box so I can sex exactly where the text draws vs. the label's placement on the screen
        // self.color = [UIColor redColor];
        //  self.colorBlendFactor =1;
        
        float scale = [[sprites objectForKey:@"Scale"]floatValue];
        float xpoint=0;
        
        float labelHeight =([[sprites objectForKey:@"Line Height"]floatValue])*scale;
        float labelWidth =([[sprites objectForKey:@"Total Width"]floatValue])*scale;/*+[[sprites objectForKey:@"Space Size"]floatValue])*scale;*/
        
        xpoint -= (labelWidth/2);
        float originalX=xpoint;
        
        if(![string rangeOfString:@"\n"].length){ //Assumed single line label
            self.size = CGSizeMake(labelWidth,labelHeight);
            int index=0;
            for (NSDictionary * chr in [sprites objectForKey:@"Sprites"]) {
                //Stepping through each sprite in the list
                MCLetterSprite * theSprite = [chr objectForKey:@"Sprite"];
                theSprite.anchorPoint = CGPointMake(0, 1);
                char nextChar,lastChar;
                float kern=0;
                
                if((index+1 != string.length) && index){
                    //Add kerning support for instance Arial Black has kerning
                    lastChar = [string characterAtIndex:index-1];
                    nextChar = [string characterAtIndex:index];
                    kern = [font kerningForFirst:[NSString stringWithFormat:@"%c",lastChar] second:[NSString stringWithFormat:@"%c",nextChar]];
                    
                    
                }
                //Set the position
                xpoint +=kern;
                xpoint += [[chr objectForKey:@"xOffset"]floatValue]*theSprite.xScale;
                
                float y = CGRectGetMidY(self.frame);
                y -=([[chr objectForKey:@"yOffset"]floatValue]*theSprite.yScale);
                y += (labelHeight)/2;
                CGPoint pos =CGPointMake(xpoint,y);
                
                CGPoint sposition = pos;
                
                theSprite.position = sposition;
                
                //Advance the xposition to the next draw location
                float xOffset =[[chr objectForKey:@"xOffset"]floatValue]*scale;
                if(![theSprite.name isEqualToString:@" "]){
                    xpoint += (([[chr objectForKey:@"xadvance"]floatValue])*theSprite.xScale);
                    xpoint-=xOffset*2;
                }
                else{
                    int amt=0;
                    if(kern >0) amt =kern;
                    xpoint += ([[chr objectForKey:@"xadvance"]floatValue]*theSprite.xScale)+(([[chr objectForKey:@"xOffset"]floatValue]*theSprite.xScale)/2);
                }
                [self addChild:theSprite];
                //Advance the index for kerning support
                index++;
            }
            
        }
        else{
            //Currently this library only supports multiple lines if lines are newline ('\n') delimited
            
            NSUInteger quantityOfLines = 1;
            
            NSUInteger stringLen = [string length];
            if( ! stringLen )
                return nil;
            
            for(NSUInteger i=0; i < stringLen-1;i++) {
                unichar c = [string characterAtIndex:i];
                if( c=='\n')
                    quantityOfLines++;
            }
            
            float lineHeight = [[sprites objectForKey:@"Line Height"]intValue]*scale;
            
            float currentHeight = lineHeight;
            NSMutableArray * linesArray = [[NSMutableArray alloc]init];
            NSMutableArray * currentLine = [[NSMutableArray alloc]init];
            
            float maxWidth =0;
            float lineWidth =0;
            
            for (NSDictionary * spriteDict in [sprites objectForKey:@"Sprites"]) {
                if([[[spriteDict objectForKey:@"Sprite"]name] isEqualToString:@"\n"]){
                    currentHeight +=lineHeight;
                    //Again, I'm sure there is a better way but here we go
                    //We've found the end of a line so we place the sprite array in to the array of lines and start a new line
                    NSArray * temp = [[NSArray alloc]initWithArray:currentLine copyItems:YES];
                    
                    [linesArray addObject:temp];
                    
                    [currentLine removeAllObjects];
                    if (lineWidth > maxWidth) {
                        maxWidth = lineWidth;
                    }
                    
                    lineWidth =0;
                    
                }
                else{
                    lineWidth +=(([[spriteDict objectForKey:@"xadvance"]floatValue])*scale);
                    [currentLine addObject:spriteDict];
                }
                
            }
            //Make sure to add the final line to the array of lines
            [linesArray addObject:currentLine];
            //Current height refers to the total height of the label
            //I should change it's name but I didn't
            currentHeight = linesArray.count *lineHeight;
            //And we've added all the character information together to get the width of each line, constantly updating the maxWidth so that we're the right size
            if(lineWidth > maxWidth) maxWidth = lineWidth;
            
            //There are no lines in the array so we'll just bug out here.
            if(!linesArray.count)return nil;
            
            if([[linesArray lastObject]count] <1){
                [linesArray removeLastObject];
                currentHeight -=  lineHeight;
            }
            
            
            self.size = CGSizeMake(maxWidth,currentHeight);
            int index=0;
            float thisLineY = 0;
            originalX = 0;
            //I took several steps with the xpos and have not consolidated them back the way they should be
            xpoint= originalX;
            xpoint  -=(maxWidth/2);
            xpoint += 2;
            for (NSArray*aLine in linesArray) {
                
                for (NSDictionary*aSprite in aLine) {
                    
                    MCLetterSprite * theSprite = [aSprite objectForKey:@"Sprite"];
                    theSprite.anchorPoint = CGPointMake(0, 1);
                    char nextChar,lastChar;
                    int kern=0;
                    
                    if((index+1 != string.length) && index){
                        //Implemnting Kerning support. It appears to work
                        //But as you can see the variable names are confusing
                        //I am new to working at this level with fonts so I had to experiement and
                        //I didn't bother to change the variable names.
                        // lastChar should be interpreted as current Character
                        // next obviously, is th next one in the list
                        lastChar = [string characterAtIndex:index-1];
                        nextChar = [string characterAtIndex:index];
                        kern = [font kerningForFirst:[NSString stringWithFormat:@"%c",lastChar] second:[NSString stringWithFormat:@"%c",nextChar]];
                    }
                    //All these Y adjustments are probably inefficent but for at least 6 lines of text they work to keep things placed correctly..
                    float y = CGRectGetMidY(self.frame)-thisLineY;
                    y +=currentHeight/2;
                    y -=([[aSprite objectForKey:@"yOffset"]floatValue]*theSprite.yScale);
                    
                    
                    xpoint +=kern;
                    xpoint += [[aSprite objectForKey:@"xOffset"]floatValue]*theSprite.xScale;
                    //Set the character's position
                    CGPoint pos =CGPointMake(xpoint,y);
                    
                    float xOffset =[[aSprite objectForKey:@"xOffset"]floatValue]*scale;
                    theSprite.position = pos;
                    //Now we advance the xpoint to the next draw location
                    if(![theSprite.name isEqualToString:@" "]){
                        xpoint += (([[aSprite objectForKey:@"xadvance"]floatValue])*theSprite.xScale);
                        xpoint-=xOffset*2;
                    }
                    else{
                        int amt=0;
                        if(kern >0) amt =kern;
                        xpoint += ([[aSprite objectForKey:@"xadvance"]floatValue]*theSprite.xScale)+(([[aSprite objectForKey:@"xOffset"]floatValue]*theSprite.xScale)/2);
                    }
                    [self addChild:theSprite];
                    //increment the index for kerning support
                    index++;
                    
                }
                //we've completed a line, time to advance the draw location's Y location.
                thisLineY += lineHeight;
                xpoint= originalX;
                xpoint  -=(maxWidth/2);
                xpoint +=2;
            }
            
        }
    }
    
    return self;
    
}

-(void)dealloc
{
    [self removeFromParent];
    self.string = nil;
}


-(void)setString:(NSString *)string
{
    
    if(!string){
        _string = nil;
        return;
    }
    SKColor * oldColor = _fontColor;
    float oldBlend = self.colorBlendFactor;
    
    //Create the sprite dictionary which contains all of the information about each sprite.
    NSDictionary * sprites = [self createSpritesFromString:string fontSize:self.fontSize];
    
    //I have used setting the color to mark the bounding box so I can set exactly where the text draws vs. the label's placement on the screen
    // self.color = [UIColor redColor];
    //  self.colorBlendFactor =1;
    
    
    NSMutableArray * newString = [[NSMutableArray alloc]init];
    
    float scale = [[sprites objectForKey:@"Scale"]floatValue];
    float xpoint=0;
    
    float labelHeight =([[sprites objectForKey:@"Line Height"]floatValue])*scale;
    float labelWidth =([[sprites objectForKey:@"Total Width"]floatValue])*scale;/*+[[sprites objectForKey:@"Space Size"]floatValue])*scale;*/
    
    xpoint -= (labelWidth/2);
    float originalX=xpoint;
    self.anchorPoint = CGPointMake(.5, .5);
    if(![string rangeOfString:@"\n"].length){ //Assumed single line label
        self.size = CGSizeMake(labelWidth,labelHeight);
        int index=0;
        for (NSDictionary * chr in [sprites objectForKey:@"Sprites"]) {
            //Stepping through each sprite in the list
            MCLetterSprite * theSprite = [chr objectForKey:@"Sprite"];
            theSprite.anchorPoint = CGPointMake(0, 1);
            char nextChar,lastChar;
            float kern=0;
            
            if((index+1 != string.length) && index){
                //Add kerning support for instance Arial Black has kerning
                lastChar = [string characterAtIndex:index-1];
                nextChar = [string characterAtIndex:index];
                kern = [self.font kerningForFirst:[NSString stringWithFormat:@"%c",lastChar] second:[NSString stringWithFormat:@"%c",nextChar]];
                
                
            }
            //Set the position
            
            xpoint +=kern;
            xpoint += [[chr objectForKey:@"xOffset"]floatValue]*theSprite.xScale;
            
            float y = (self.frame.size.height/2)-(([[sprites objectForKey:@"Line Height"]floatValue]*scale)/2);//CGRectGetMidY(self.frame);
            y -=([[chr objectForKey:@"yOffset"]floatValue]*theSprite.yScale);
            y += (labelHeight)/2;
            CGPoint pos =CGPointMake(xpoint,y);
            
            CGPoint sposition = pos;
            
            theSprite.position = sposition;
            
            //Advance the xposition to the next draw location
            float xOffset =[[chr objectForKey:@"xOffset"]floatValue]*scale;
            if(![theSprite.name isEqualToString:@" "]){
                xpoint += (([[chr objectForKey:@"xadvance"]floatValue])*theSprite.xScale);
                xpoint-=xOffset*2;
            }
            else{
                int amt=0;
                if(kern >0) amt =kern;
                xpoint += ([[chr objectForKey:@"xadvance"]floatValue]*theSprite.xScale)+(([[chr objectForKey:@"xOffset"]floatValue]*theSprite.xScale)/2);
            }
            
            //Advance the index for kerning support
            index++;
            
            [newString addObject:theSprite];
        }
        
    }
    else{
        //Currently this library only supports multiple lines if lines are newline ('\n') delimited
        
        NSUInteger quantityOfLines = 1;
        
        NSUInteger stringLen = [string length];
        if( ! stringLen )
            return;
        
        for(NSUInteger i=0; i < stringLen-1;i++) {
            unichar c = [string characterAtIndex:i];
            if( c=='\n')
                quantityOfLines++;
        }
        
        float lineHeight = [[sprites objectForKey:@"Line Height"]intValue]*scale;
        
        float currentHeight = lineHeight;
        NSMutableArray * linesArray = [[NSMutableArray alloc]init];
        NSMutableArray * currentLine = [[NSMutableArray alloc]init];
        
        float maxWidth =0;
        float lineWidth =0;
        
        for (NSDictionary * spriteDict in [sprites objectForKey:@"Sprites"]) {
            if([[[spriteDict objectForKey:@"Sprite"]name] isEqualToString:@"\n"]){
                currentHeight +=lineHeight;
                //Again, I'm sure there is a better way but here we go
                //We've found the end of a line so we place the sprite array in to the array of lines and start a new line
                NSArray * temp = [[NSArray alloc]initWithArray:currentLine copyItems:YES];
                
                [linesArray addObject:temp];
                
                [currentLine removeAllObjects];
                if (lineWidth > maxWidth) {
                    maxWidth = lineWidth;
                }
                
                lineWidth =0;
                
            }
            else{
                lineWidth +=(([[spriteDict objectForKey:@"xadvance"]floatValue])*scale);
                [currentLine addObject:spriteDict];
            }
            
        }
        //Make sure to add the final line to the array of lines
        [linesArray addObject:currentLine];
        //Current height refers to the total height of the label
        //I should change it's name but I didn't
        currentHeight = linesArray.count *lineHeight;
        //And we've added all the character information together to get the width of each line, constantly updating the maxWidth so that we're the right size
        if(lineWidth > maxWidth) maxWidth = lineWidth;
        
        //There are no lines in the array so we'll just bug out here.
        if(!linesArray.count)return;
        
        if([[linesArray lastObject]count] <1){
            [linesArray removeLastObject];
            currentHeight -=  lineHeight;
        }
        
        
        self.size = CGSizeMake(maxWidth,currentHeight);
        int index=0;
        float thisLineY = 0;
        originalX = 0;
        //I took several steps with the xpos and have not consolidated them back the way they should be
        xpoint= originalX;
        xpoint  -=(maxWidth/2);
        xpoint += 2;
        
        for (NSArray*aLine in linesArray) {
            
            for (NSDictionary*aSprite in aLine) {
                
                MCLetterSprite * theSprite = [aSprite objectForKey:@"Sprite"];
                theSprite.anchorPoint = CGPointMake(0, 1);
                char nextChar,lastChar;
                int kern=0;
                
                if((index+1 != string.length) && index){
                    //Implemnting Kerning support. It appears to work
                    //But as you can see the variable names are confusing
                    //I am new to working at this level with fonts so I had to experiement and
                    //I didn't bother to change the variable names.
                    // lastChar should be interpreted as current Character
                    // next obviously, is th next one in the list
                    lastChar = [string characterAtIndex:index-1];
                    nextChar = [string characterAtIndex:index];
                    kern = [self.font kerningForFirst:[NSString stringWithFormat:@"%c",lastChar] second:[NSString stringWithFormat:@"%c",nextChar]];
                }
                //All these Y adjustments are probably inefficent but for at least 6 lines of text they work to keep things placed correctly..
                
                // self.colorBlendFactor =.8;
                // self.color = [UIColor redColor];
                float y = 0;
                y -=thisLineY;
                y +=currentHeight/2;
                y -=([[aSprite objectForKey:@"yOffset"]floatValue]*theSprite.yScale);
                
                
                xpoint +=kern;
                xpoint += [[aSprite objectForKey:@"xOffset"]floatValue]*theSprite.xScale;
                //Set the character's position
                CGPoint pos =CGPointMake(xpoint,y);
                
                float xOffset =[[aSprite objectForKey:@"xOffset"]floatValue]*scale;
                theSprite.position = pos;
                //Now we advance the xpoint to the next draw location
                if(![theSprite.name isEqualToString:@" "]){
                    xpoint += (([[aSprite objectForKey:@"xadvance"]floatValue])*theSprite.xScale);
                    xpoint-=xOffset*2;
                }
                else{
                    int amt=0;
                    if(kern >0) amt =kern;
                    xpoint += ([[aSprite objectForKey:@"xadvance"]floatValue]*theSprite.xScale)+(([[aSprite objectForKey:@"xOffset"]floatValue]*theSprite.xScale)/2);
                }
                
                //increment the index for kerning support
                index++;
                
                [newString addObject:theSprite];
            }
            //we've completed a line, time to advance the draw location's Y location.
            thisLineY += lineHeight;
            xpoint= originalX;
            xpoint  -=(maxWidth/2);
            xpoint +=2;
            
        }
        CGPoint p = self.position;
        p.y -=(currentHeight/2)/linesArray.count;
        self.position = p;
        
    }
    // @synchronized(self.children){
    _string = nil;
    _string = [[NSString alloc]initWithString:string];
    [self performSelectorOnMainThread:@selector(removeAllChildren) withObject:Nil waitUntilDone:YES];
    for (SKSpriteNode*theSprite in newString) {
        @synchronized(self.children){
            [self addChild:theSprite];
        }
    }
    
    //}
    self.color = oldColor;
    self.colorBlendFactor = oldBlend;
    
}


#if TARGET_OS_IPHONE
-(void)setColor:(SKColor *)color
{
    super.color = [SKColor clearColor];
    _fontColor= color;
    @synchronized(self.children){
        NSArray * ar = [NSArray arrayWithArray:self.children];
        for (SKSpriteNode*letter in ar) {
            letter.color = color;
            
        }
    }
}




-(SKColor*)color
{
    if(self.children.count){
        return _fontColor;
    }
    else return [SKColor clearColor];
}
#else

-(void)setColor:(NSColor *)color
{
    super.color = [NSColor clearColor];
    _fontColor = color;
    @synchronized(self.children){
        NSArray * ar = [NSArray arrayWithArray:self.children];
        for (SKSpriteNode*letter in ar) {
            letter.color = color;
            
        }
    }
}




-(NSColor*)color
{
    if(self.children.count){
        return _fontColor;
    }
    else return [NSColor clearColor];
}


#endif

-(void)setColorBlendFactor:(CGFloat)colorBlendFactor
{
    super.colorBlendFactor = colorBlendFactor;
    @synchronized(self.children){
        NSArray * ar = [NSArray arrayWithArray:self.children];
        for (SKSpriteNode*letter in ar) {
            letter.colorBlendFactor = self.colorBlendFactor;
            self.color = _fontColor;
        }
    }
}

-(void)setFontSize:(float)fontSize
{
    _fontSize = fontSize;
    if(self.string)self.string = self.string;
}




@end