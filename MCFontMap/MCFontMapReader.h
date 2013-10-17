//
//  MCFontMapReader.h
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//


#import <SpriteKit/SpriteKit.h>
#import "Globals.h"


@interface MCFontMapReader : NSObject
{
    
}


@property (nonatomic,strong) NSMutableDictionary * fontDict;
@property (nonatomic,strong) NSMutableDictionary * kerningDict;
@property (nonatomic,strong) MCImage * fontImage;
@property (nonatomic,strong) NSMutableDictionary * fontData;


-(id)initWithFontPackageNamed:(NSString*)fontPackageName isXML:(BOOL)xml;
-(void)setValue:(id)value forKey:(NSString *)key forCharacter:(NSString*)ch;

@end
