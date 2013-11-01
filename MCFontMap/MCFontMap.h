//
//  MCFontMap.h
//  MCFontMap
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 April Gendill. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

#import <SpriteKit/SpriteKit.h>
#import "XMLReader.h"
#import "MCFontMapReader.h"
#import "MCFont.h"
#import "MCFontMapLabel.h"
#import "MCLetterSprite.h"
#import "MCFontManager.h"