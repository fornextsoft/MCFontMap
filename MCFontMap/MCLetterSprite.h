//
//  MCLetterSprite.h
//  MCFontMap
//
//  Created by April Gendill on 9/24/13.
//  Copyright (c) 2013 April Gendill. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MCLetterSprite : SKSpriteNode
{
    
}



@property (nonatomic) BOOL passThrough; //Passes touches through to parent Defaults to YES
@property (nonatomic) BOOL movable; //Sprite can be moved defaults to NO


@end
