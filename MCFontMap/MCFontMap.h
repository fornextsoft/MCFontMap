//
//  MCFontMap.h
//  MCFontMap
//
//  Created by April Gendill on 9/20/13.
//  Copyright (c) 2013 April Gendill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "XMLReader.h"
#import "MCFontMapReader.h"
#import "MCFont.h"
#import "MCFontMapLabel.h"



float getXRelevantToWidth(float width,float xPos); //Converts a UIKit x coordinate to SpriteKit Node coordinate
float getYRelevantToHeight(float height,float yPos);//Converts a UIKit y coordinate to Spritekit Node coordinate

//Those functons don't work exactly correctly and I'm not good enough at math to make them work