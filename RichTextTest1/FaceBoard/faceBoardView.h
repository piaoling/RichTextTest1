//
//  faceBoardView.h
//  RichTextTest1
//
//  Created by 赵 峰 on 13-4-3.
//  Copyright (c) 2013年 赵 峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceBoardPageControl.h"

@interface faceBoardView : UIView<UIScrollViewDelegate>
{
    UIScrollView *faceBoardScrollView;
    NSDictionary *_faceDic;
    FaceBoardPageControl *_facePageControl;
}

@property (nonatomic, strong) UITextView *inputTextView;

@end
