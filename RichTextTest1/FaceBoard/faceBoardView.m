//
//  faceBoardView.m
//  RichTextTest1
//
//  Created by 赵 峰 on 13-4-3.
//  Copyright (c) 2013年 赵 峰. All rights reserved.
//

#import "faceBoardView.h"
#import "faceButton.h"

@implementation faceBoardView
@synthesize inputTextView;

-(void)dealloc
{
    self.inputTextView = nil;
    faceBoardScrollView = nil;
    _faceDic = nil;
    _facePageControl = nil;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 216)];
    
    if (self)
    {
        _faceDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faceDic_en" ofType:@"plist"]];
        faceBoardScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 190)];
        faceBoardScrollView.pagingEnabled = YES;
        faceBoardScrollView.contentSize = CGSizeMake((85 / 28 + 1) * 320, 190);
        faceBoardScrollView.showsHorizontalScrollIndicator = NO;
        faceBoardScrollView.showsVerticalScrollIndicator = NO;
        faceBoardScrollView.delegate = self;
        
        for (int i = 1; i <= 85; i++)
        {
            faceButton *oneFaceButton = [faceButton buttonWithType:UIButtonTypeCustom];
            oneFaceButton.buttonIndex = i;
            
            [oneFaceButton addTarget:self
                              action:@selector(clickFaceBtn:)
                    forControlEvents:UIControlEventTouchUpInside];
            
            oneFaceButton.frame = CGRectMake((((i - 1) % 28) % 7) * 44 + (i - 1) / 28 * 320, (((i - 1) % 28) / 7) * 44 + 8, 44, 44);
            [oneFaceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d", i]] forState:UIControlStateNormal];
            [faceBoardScrollView addSubview:oneFaceButton];
            oneFaceButton = nil;
        }
        [self addSubview:faceBoardScrollView];
        
        _facePageControl = [[FaceBoardPageControl alloc] initWithFrame:CGRectMake(110, 190, 100, 20)];
        [_facePageControl addTarget:self
                             action:@selector(pageChange:)
                   forControlEvents:UIControlEventValueChanged];
        
        _facePageControl.numberOfPages = 85 / 28 + 1;
        _facePageControl.currentPage = 0;
        [self addSubview:_facePageControl];
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setTitle:@"delete" forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"backFace"] forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"backFaceSelect"] forState:UIControlStateSelected];
        [back addTarget:self
                 action:@selector(clickDeleteFace)
       forControlEvents:UIControlEventTouchUpInside];
        
        back.frame = CGRectMake(270, 185, 38, 27);
        [self addSubview:back];
    }
    
    return self;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_facePageControl setCurrentPage:faceBoardScrollView.contentOffset.x / 320];
    [_facePageControl updateCurrentPageDisplay];
}

- (void)pageChange:(id)sender
{
    [faceBoardScrollView setContentOffset:CGPointMake(_facePageControl.currentPage * 320, 0) animated:YES];
    [_facePageControl setCurrentPage:_facePageControl.currentPage];
}

- (void)clickFaceBtn:(id)sender
{
    int i = ((faceButton *)sender).buttonIndex;
    
    if (self.inputTextView)
    {
        NSMutableString *faceString = [[NSMutableString alloc] initWithString:self.inputTextView.text];
        [faceString appendString:[_faceDic objectForKey:[NSString stringWithFormat:@"%03d", i]]];
        self.inputTextView.text = faceString;
        faceString = nil;
    }
}

- (void)clickDeleteFace{
    
    
    if (self.inputTextView)
    {
        NSString *inputString;
        inputString = self.inputTextView.text;
        
        NSString *string = nil;
        NSInteger stringLength = inputString.length;
        if (stringLength > 0)
        {
            if ([@"]" isEqualToString:[inputString substringFromIndex:stringLength-1]])
            {
                if ([inputString rangeOfString:@"["].location == NSNotFound)
                {
                    string = [inputString substringToIndex:stringLength - 1];
                }
                else
                {
                    string = [inputString substringToIndex:[inputString rangeOfString:@"[" options:NSBackwardsSearch].location];
                }
            }
            else
            {
                string = [inputString substringToIndex:stringLength - 1];
            }
        }
        
        self.inputTextView.text = string;
        
        string = nil;
        inputString = nil;
    }
    
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
