//
//  MCFontMapReader.m
//  MissleCommand
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//

#import "MCFontMapReader.h"

@implementation MCFontMapReader


-(void)parseCocos2d:(NSString*)fontPackageName
{
    NSString* fontName = [fontPackageName stringByDeletingPathExtension];
    NSString * pff = [[NSBundle mainBundle]pathForResource:fontName ofType:@"fntpkg"];
    NSString * fontFile = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.fnt",pff,fontName] encoding:NSUTF8StringEncoding error:nil];
    self.fontImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",pff,fontName]];
    
    //This will break the file data in half assuming it was made with bgGlyph this should work
    //If the font file information is placed at the end of the document this will not work.
    NSRange rangeOf = [fontFile rangeOfString:@"\nchar "];
    NSRange kernRange= [fontFile rangeOfString:@"\nkernings"];
    
    //Separate the file info and the characters
    NSString * fontInfo = [fontFile substringToIndex:rangeOf.location];
    NSString * fontData,*kerns;
    if(!kernRange.length){
        fontData = [fontFile substringFromIndex:rangeOf.location];
    }
    else{
        NSString *f = [fontFile substringFromIndex:rangeOf.location];
        kerns = [fontFile substringFromIndex:kernRange.location + kernRange.length];
        kernRange = [f rangeOfString:@"\nkernings"];
        fontData = [f substringToIndex:kernRange.location];
     //   NSLog(@"kerns %@",kerns);
      //  NSLog(@"fontdata %@",fontData);
    }
    NSArray * kernArray = [kerns componentsSeparatedByString:@"\n"];
   //  NSLog(@"Kern count %i",kernArray.count);

    for (NSString*lineK in kernArray) {
        if([lineK rangeOfString:@"count="].length)continue;
        NSArray * la = [lineK componentsSeparatedByString:@" "];
        if(la.count <2)continue;
   //     NSLog(@"LA %@",la);
        NSArray * first = [[la objectAtIndex:1]componentsSeparatedByString:@"="];
        NSArray * second = [[la objectAtIndex:2]componentsSeparatedByString:@"="];
        NSArray * amountArray = [[la objectAtIndex:3]componentsSeparatedByString:@"="];
        
        NSString * charValue1 = [NSString stringWithFormat:@"%c",[[first objectAtIndex:1]intValue]];
        NSString * charValue2 = [NSString stringWithFormat:@"%c",[[second objectAtIndex:1]intValue]];
        NSNumber * amount = [NSNumber numberWithInt:[[amountArray objectAtIndex:1]intValue]];
        char fk =[[first objectAtIndex:1]intValue];
        char lk = [[second objectAtIndex:1]intValue];
        int kv =(fk<<16) | (lk&0xffff);
        
        NSString * key = [NSString stringWithFormat:@"%i",kv];

        [self.kerningDict setObject:amount forKey:key];
    }
  //  NSLog(@"Kern dict %@",self.kerningDict);
   
    //Create an array of characters
    NSArray* charsArray = [fontData componentsSeparatedByString:@"\n"];
  //  NSLog(@"Chars Array count %i",charsArray.count);
    self.fontDict = [[NSMutableDictionary alloc]init];
    //Step the array of character info
    for (NSString * str in charsArray) {
        if(!str.length)continue;
        NSArray * anArray = [str componentsSeparatedByString:@" "];
        NSMutableDictionary * charDict = [[NSMutableDictionary alloc]init];
        //Create an array of each line, then use the data to make the char's entry in the font dictionary
        for (NSString* str1 in anArray) {
            if (![str1 rangeOfString:@"="].length) {
                continue;
            }
            
            NSArray * item = [str1 componentsSeparatedByString:@"="];
            [charDict setObject:[item objectAtIndex:1] forKey:[item objectAtIndex:0]];
            
        }
        //Of course set the object for it's letter key, in other words the key 'w' returns the data for the letter w
        NSString * key = [NSString stringWithFormat:@"%c",[[charDict objectForKey:@"id"]intValue]];
        [self.fontDict setObject:charDict forKey:key];
    }
    //Grab the font information and break it in to the lines of information
    NSArray * fInfo = [fontInfo componentsSeparatedByString:@"\n"];
    self.fontData = [[NSMutableDictionary alloc]init];
    for (NSString*str in fInfo) {
        //create an array from each line
        NSArray * lineArray  = [str componentsSeparatedByString:@" "];
        if(lineArray.count <=1){
            continue;
        }
        //The first item in the array is the item's type like common, page etc.
        NSArray * cArray =[lineArray subarrayWithRange:NSMakeRange(1, lineArray.count -1)];
        for (NSString*str1 in cArray) {
            //break up the values and place them in the font information dictionary
            NSArray * last = [str1 componentsSeparatedByString:@"="];
            if(last.count <=1) continue;
            NSString * object = [[last objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            [self.fontData setObject:object forKey:[last objectAtIndex:0]];
        }
    }

    
    [self parseFonts];

}


-(void)autoKern
{
    return;
    NSNumber * amount = [NSNumber numberWithInt:-10];
    char fk =105;
    char lk = 110;
    int kv =(fk<<16) | (lk&0xffff);
    NSString * key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];

    
    amount = [NSNumber numberWithInt:-6];
    fk =105;
    lk = 119;
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];
    
    fk =73;
    lk = 78;
    amount = [NSNumber numberWithInt:-5];
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];

    fk =110;
    lk = 32;
    amount = [NSNumber numberWithInt:-7];
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];
    
    fk =78;
    lk = 73;
    amount = [NSNumber numberWithInt:-5];
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];
    
 
    
    fk =111;
    lk = 108;
    amount = [NSNumber numberWithInt:-4];
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];

    
    fk =108;
    lk = 111;
    amount = [NSNumber numberWithInt:-4];
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];
    
    fk =100;
    lk = 108;
    amount = [NSNumber numberWithInt:-3];
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];

    
    fk =108;
    lk = 108;
    amount = [NSNumber numberWithInt:-5];
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];

    fk =111;
    lk = 108;
    amount = [NSNumber numberWithInt:2];
    kv =(fk<<16) | (lk&0xffff);
    key = [NSString stringWithFormat:@"%i",kv];
    [self.kerningDict setObject:amount forKey:key];
}

-(id)initWithFontPackageNamed:(NSString*)fontPackageName isXML:(BOOL)xml
{
    if(self=[super init]){
        
        NSString* fontName = [fontPackageName stringByDeletingPathExtension];
        NSString * pff = [[NSBundle mainBundle]pathForResource:fontName ofType:@"fntpkg"];
        NSString * fontFileTest = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.fnt",pff,fontName] encoding:NSUTF8StringEncoding error:nil];
        if([fontFileTest rangeOfString:@"<?xml"].length){
            xml =YES;
        }
        else{
            xml =NO;
        }
        self.kerningDict = [[NSMutableDictionary alloc]init];
        
        if(xml){
            //Read the xml file in to NSData for the parser
            NSData * xmlData = [[NSData alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.fnt",pff,fontName]];
            //Snag the font image
            self.fontImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",pff,fontName]];
            
            if(xmlData){
                //It's sparrow we'll read it
                NSError *error = nil;
                NSDictionary * fd = [XMLReader dictionaryForXMLData:xmlData error:&error];
                NSLog(@"Error %@",error);
                //reading from xml to nsdictionary is messy but grab the chars here
                NSDictionary * charDict = [[fd objectForKey:@"font"]objectForKey:@"chars"];
                //init the instance's font dictionary
                self.fontDict = [[NSMutableDictionary alloc]init];
                                 
                for (NSDictionary*thisChar in [charDict objectForKey:@"char"]) {
                    //In the font dictionary the letter is the key
                    NSString * str= [NSString stringWithFormat:@"%c",[[thisChar objectForKey:@"id"]intValue]];
                    [self.fontDict setObject:thisChar forKey:str];
                }
                //This is the info key containging such info as Bol, itallic etc.
                self.fontData = [[NSMutableDictionary alloc]initWithDictionary:[[fd objectForKey:@"font"] objectForKey:@"info"] copyItems:YES];
                [self.fontData addEntriesFromDictionary:[[fd objectForKey:@"font"] objectForKey:@"common"]];
                [self.fontData addEntriesFromDictionary:[[fd objectForKey:@"font"] objectForKey:@"pages"]];
                NSMutableDictionary *kd = [[NSMutableDictionary alloc]initWithDictionary:[[fd objectForKey:@"font"] objectForKey:@"kernings"] copyItems:YES];
                
                [self autoKern];
              //  NSLog(@"Kerning %@",[kd objectForKey:@"kerning"]);
                for (NSDictionary*pair in [kd objectForKey:@"kerning"]) {
                   // NSLog(@"Pair %@",pair);
                    NSNumber * amount = [NSNumber numberWithInt:[[pair objectForKey:@"amount"]intValue]];
                    char fk =[[pair objectForKey:@"first"]intValue];
                    char lk = [[pair objectForKey:@"second"]intValue];
                    int kv =(fk<<16) | (lk&0xffff);
                    NSLog(@"Key %i",kv);
                    NSString * key = [NSString stringWithFormat:@"%i",kv];
                    [self.kerningDict setObject:amount forKey:key];
                }
            
            }
            
            else{
                
                [self parseCocos2d:fontPackageName];
                [self autoKern];
            }
            
            
            
        }
        else{

            [self parseCocos2d:fontPackageName];
            [self autoKern];
            //cocos2d reader here
        }

    }
  //  NSLog(@"%@",self.kerningDict);
    [self parseFonts];
    return self;
}


-(void)setValue:(id)value forKey:(NSString *)key forCharacter:(NSString*)ch
{
    NSMutableDictionary * fd = [self.fontDict objectForKey:ch];
    [fd setObject:value forKey:key];
}

-(void)parseFonts
{
    NSMutableDictionary * final =[[NSMutableDictionary alloc]init];
    for (NSString*chr in self.fontDict) {
        
        NSDictionary * ch = [self.fontDict objectForKey:chr];
        
        float xOrigin=0,yOrigin=0;
        float myWidth=0,myHeight=0;
        
        xOrigin = [[ch objectForKey:@"x"]floatValue];
        yOrigin = [[ch objectForKey:@"y"]floatValue];
        myWidth = [[ch objectForKey:@"width"]floatValue];
        myHeight = [[ch objectForKey:@"height"]floatValue];
        float xoff = [[ch objectForKey:@"xoffset"]floatValue];
        float yoff = [[ch objectForKey:@"yoffseet"]floatValue];
        //I probably will regret this but it was to fix an issue with 0 sized image.
        if(myHeight == 0) myHeight =1;
        if(myWidth == 0) myWidth =1;

        //create a rect for the char in question. Code borrowed from: http://stackoverflow.com/questions/8538250/uiimage-by-selecting-part-of-another-uiimage
        CGRect myImageArea = CGRectMake(xOrigin, yOrigin, myWidth, myHeight);//newImage
        //Create the image
        UIImage *mySubimage  = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.fontImage.CGImage, myImageArea)];
        //Add the image to the char's dictionary entry.
        NSMutableDictionary * thisItem = [[NSMutableDictionary alloc]initWithDictionary:ch copyItems:YES];
        [thisItem setObject:mySubimage forKey:@"Image"];
        [final setObject:thisItem forKey:chr];
    }
    [self.fontDict removeAllObjects];
    [self.fontDict setDictionary:final];
   // NSLog(@"Font info %@",self.fontData);
//    NSLog(@"Font Dict %@",self.fontDict);
}

@end
