//
//  FaceBoardPageControl.m
//  RichTextTest1
//
//  Created by 赵 峰 on 13-4-7.
//  Copyright (c) 2013年 赵 峰. All rights reserved.
//

#import "FaceBoardPageControl.h"

@implementation FaceBoardPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        activeImage = [UIImage imageNamed:@"active_page_image"];
        inactiveImage = [UIImage imageNamed:@"inactive_page_image"];
        [self setCurrentPage:1];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    activeImage = [UIImage imageNamed:@"active_page_image"];
    inactiveImage = [UIImage imageNamed:@"inactive_page_image"];
    [self setCurrentPage:1];
    return self;
}

-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if (i == self.currentPage) dot.image = activeImage;
        else dot.image = inactiveImage;
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}

-(void)dealloc
{
    activeImage = nil;
    inactiveImage = nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
