//
//  MCFontMapReader.h
//  MissleCommand
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 FOR neXtSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"


@interface MCFontMapReader : NSObject
{
    
}


@property (nonatomic,strong) NSMutableDictionary * fontDict;
@property (nonatomic,strong) UIImage * fontImage;
@property (nonatomic,strong) NSMutableDictionary * fontData;


-(id)initWithFontPackageNamed:(NSString*)fontPackageName isXML:(BOOL)xml;


@end
