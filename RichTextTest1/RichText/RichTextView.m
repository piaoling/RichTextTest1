//
//  RichTextView.m
//  RichTextTest1
//
//  Created by 赵 峰 on 13-4-8.
//  Copyright (c) 2013年 赵 峰. All rights reserved.
//

#import "RichTextView.h"

#define BEGIN_FLAG @"[/"
#define END_FLAG @"]"
#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
#define MAX_WIDTH (280 - 30)

@implementation RichTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//photo-text
-(void)getImageRange:(NSString*)message : (NSMutableArray*)array
{
    NSRange range  = [message rangeOfString:BEGIN_FLAG];
    NSRange range1 = [message rangeOfString:END_FLAG];
    
    //To determine whether the current string containing the expression sign
    if (range.length > 0 && range1.length > 0)
    {
        if (range.location > 0)
        {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location + 1 - range.location)]];
            NSString *str = [message substringFromIndex:range1.location + 1];
            [self getImageRange:str :array];
        }
        else
        {
            NSString *nextstr = [message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            
            //Exclude the text “”
            if (![nextstr isEqualToString:@""])
            {
                [array addObject:nextstr];
                NSString *str = [message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }
            else
            {
                return;
            }
        }
        
    }
    else if (message != nil)
    {
        [array addObject:message];
    }
}


- (id)initWithRichMessage:(NSString *)richMessage
{
    self = [self initWithFrame:CGRectZero];
    
    if (self)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [self getImageRange:richMessage :array];
        NSArray *data = array;
        array = nil;
        
        UIFont *fon = [UIFont systemFontOfSize:14.0f];
        CGFloat upX = 0;
        CGFloat upY = 0;
        CGFloat X = 0;
        CGFloat Y = 0;
        
        if (data)
        {
            for (int i = 0; i < [data count]; i++)
            {
                NSString *str = [data objectAtIndex:i];
                NSLog(@"str--->%@",str);
                
                if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
                {
                    if (upX >= MAX_WIDTH)
                    {
                        upY = upY + KFacialSizeHeight + 6;
                        upX = 0;
                        X = MAX_WIDTH;
                        Y = upY;
                    }
                    NSLog(@"str(image)---->%@",str);
                    
                    
                    NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faceDic_en" ofType:@"plist"]];
                    NSArray *faceArray = [self createFaceArray:faceDic];
//                    NSArray *faceArray = [faceDic allValues];
                    NSUInteger index = [faceArray indexOfObject:str];
                    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d", index + 1]]];

                    imgView.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                    [self addSubview:imgView];
                    imgView = nil;
                    upX = KFacialSizeWidth + upX;
                    if (X < MAX_WIDTH)
                    {
                        X = upX;
                    }
                    
                }
                else
                {
                    for (int j = 0; j < [str length]; j++)
                    {
                        NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                        if (upX >= MAX_WIDTH)
                        {
                            upY = upY + KFacialSizeHeight + 6;
                            upX = 0;
                            X = MAX_WIDTH;
                            Y = upY;
                        }
                        CGSize size = [temp sizeWithFont:fon constrainedToSize:CGSizeMake(MAX_WIDTH, 40)];
                        UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX, upY, size.width, size.height)];
                        la.font = fon;
                        la.text = temp;
                        la.backgroundColor = [UIColor clearColor];
                        [self addSubview:la];

                        la = nil;
                        upX = upX + size.width;
                        if (X < MAX_WIDTH)
                        {
                            X = upX;
                        }
                    }
                }
            }
        }
        fon = nil;
        self.frame = CGRectMake(10, 8, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
        NSLog(@"%.1f %.1f", X, Y);
    }
    
    return self;
}

- (NSArray *)createFaceArray:(NSDictionary *)faceDic
{
    NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:[faceDic count]];
    
    for (int i = 0; i < [faceDic count]; i++) {
        NSString *value = [faceDic objectForKey:[NSString stringWithFormat:@"%03d", i + 1]];
        [returnArray addObject:value];
    }
    
    return returnArray;
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
