//
//  ViewController.h
//  RichTextTest1
//
//  Created by 赵 峰 on 13-4-2.
//  Copyright (c) 2013年 赵 峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "faceBoardView.h"

@interface ViewController : UIViewController
{
    UIToolbar *keyboardToolbar;
    UISegmentedControl *nextPreviousControl;
    faceBoardView *_oneFaceBoardView;
}

@property (nonatomic, retain) UISegmentedControl *nextPreviousControl;
@property (nonatomic, retain) UIToolbar *keyboardToolbar;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIButton *richTextButton;

- (NSArray *)customKBToolBar;

- (void)dismissKeyboard:(id)sender;

- (IBAction)clickRichTextButton:(id)sender;

@end
