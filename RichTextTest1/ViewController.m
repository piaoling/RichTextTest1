//
//  ViewController.m
//  RichTextTest1
//
//  Created by 赵 峰 on 13-4-2.
//  Copyright (c) 2013年 赵 峰. All rights reserved.
//

#import "ViewController.h"
#import "faceBoardView.h"
#import "RichTextView.h"

Boolean keyboardShouldChange = TRUE;
Boolean showFaceBoard = FALSE;

@interface ViewController ()

@end

@implementation ViewController

@synthesize keyboardToolbar, nextPreviousControl, textView, richTextButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _oneFaceBoardView = [[faceBoardView alloc] init];
    
    self.richTextButton.alpha = 1;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

//    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if (version >= 5.0) {
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    }
    
    self.textView.layer.borderColor = UIColor.grayColor.CGColor;
    self.textView.layer.borderWidth = 2;
    [self.textView.layer setCornerRadius: 6];
    [self.textView.layer setMasksToBounds:YES];

    
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.keyboardToolbar = nil;
    self.nextPreviousControl = nil;
    self.textView = nil;
    _oneFaceBoardView = nil;
    self.richTextButton = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
//    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if (version >= 5.0) {
//        
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
//    }
}

#pragma mark -
#pragma mark make toolbar

- (NSArray *)customKBToolBar
{
    UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [faceButton setBackgroundImage:[UIImage imageNamed:@"001.png"] forState:UIControlStateNormal];
    [faceButton addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    faceButton.frame = CGRectMake(0, 0, 30, 30);
    
//    UIBarButtonItem *faceBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"001.png"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items = [[NSArray alloc] initWithObjects:flex, faceButton, nil];
    
//    faceBarButtonItem = nil;
    flex = nil;
    faceButton = nil;
    
    return items;
}

#pragma mark -
#pragma mark UIWindow Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
	CGFloat statusBarHeight = self.view.frame.origin.y;
	CGRect beginFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	CGRect endFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
	NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	if (nil == keyboardToolbar) {
    
        keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        keyboardToolbar.tintColor = [UIColor darkGrayColor];
        
//        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
//        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//        
//        UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
//                                                                                 NSLocalizedString(@"Previous",@"Previous form field"),
//                                                                                 NSLocalizedString(@"Next",@"Next form field"),
//                                                                                 nil]];
//        control.segmentedControlStyle = UISegmentedControlStyleBar;
//        control.tintColor = [UIColor darkGrayColor];
//        control.momentary = YES;
//        [control addTarget:self action:@selector(nextPrevious:) forControlEvents:UIControlEventValueChanged];
//        
//        UIBarButtonItem *controlItem = [[UIBarButtonItem alloc] initWithCustomView:control];
//        
//        self.nextPreviousControl = control;
//        
//        
//        NSArray *items = [[NSArray alloc] initWithObjects:controlItem, flex, barButtonItem, nil];
//        [keyboardToolbar setItems:items];
//        
//        control = nil;
//        barButtonItem = nil;
//        flex = nil;
//        items = nil;

//        [keyboardToolbar setItems:[self customKBToolBar]];

        
        UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [faceButton setBackgroundImage:[UIImage imageNamed:@"001.png"] forState:UIControlStateNormal];
        [faceButton addTarget:self action:@selector(clickFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
        faceButton.frame = CGRectMake(self.view.bounds.size.width - 30 - 7, 7, 30, 30);
        [keyboardToolbar addSubview:faceButton];
        
        keyboardToolbar.frame = CGRectMake(beginFrame.origin.x, //beginCentre.x - (keyboardBounds.size.width/2),
                                           beginFrame.origin.y - keyboardToolbar.frame.size.height - statusBarHeight, //beginCentre.y - (keyboardBounds.size.height/2) - keyboardToolbar.frame.size.height,
                                           keyboardToolbar.frame.size.width,
                                           keyboardToolbar.frame.size.height);
        
        [self.view addSubview:keyboardToolbar];

	}
	
	[UIView beginAnimations:@"RS_showKeyboardAnimation" context:nil];
	[UIView setAnimationCurve:animationCurve];
	[UIView setAnimationDuration:animationDuration];
	
	keyboardToolbar.alpha = 1.0;
	keyboardToolbar.frame = CGRectMake(endFrame.origin.x, //endCentre.x - (keyboardBounds.size.width/2),
									   endFrame.origin.y - keyboardToolbar.frame.size.height - statusBarHeight, //endCentre.y - (keyboardBounds.size.height/2) - keyboardToolbar.frame.size.height - self.view.frame.origin.y,
									   keyboardToolbar.frame.size.width,
									   keyboardToolbar.frame.size.height);
	
	[UIView commitAnimations];
	
	//keyboardToolbarShouldHide = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	if (nil == keyboardToolbar || !keyboardShouldChange) {
		return;
	}
	
	CGFloat statusBarHeight = self.view.frame.origin.y;
	//CGRect beginFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	CGRect endFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
	NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	[UIView beginAnimations:@"RS_hideKeyboardAnimation" context:nil];
	[UIView setAnimationCurve:animationCurve];
	[UIView setAnimationDuration:animationDuration];
	
	
	keyboardToolbar.alpha = 0.0;
	keyboardToolbar.frame = CGRectMake(endFrame.origin.x, //endCentre.x - (keyboardBounds.size.width/2),
									   endFrame.origin.y - statusBarHeight - keyboardToolbar.frame.size.height, //endCentre.y - (keyboardBounds.size.height/2) - keyboardToolbar.frame.size.height,
									   keyboardToolbar.frame.size.width,
									   keyboardToolbar.frame.size.height);
	
	[UIView commitAnimations];
}

-(void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    CGFloat statusBarHeight = self.view.frame.origin.y;
    //CGRect beginFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // Get the duration of the animation.
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView beginAnimations:@"RS_changeKeyboardAnimation" context:nil];
	[UIView setAnimationCurve:animationCurve];
	[UIView setAnimationDuration:animationDuration];
    
    keyboardToolbar.frame = CGRectMake(endFrame.origin.x, //endCentre.x - (keyboardBounds.size.width/2),
									   endFrame.origin.y - statusBarHeight - keyboardToolbar.frame.size.height, //endCentre.y - (keyboardBounds.size.height/2) - keyboardToolbar.frame.size.height,
									   keyboardToolbar.frame.size.width,
									   keyboardToolbar.frame.size.height);
	
	[UIView commitAnimations];
}

- (void)keyboardDidHide:(NSNotification*)notification {
    //_faceBoard.inputTextView = self.textView;
    //self.textView.inputView = _faceBoard;
    
    [self.textView becomeFirstResponder];
    
}

#pragma mark -
#pragma mark Button Actions

- (void)dismissKeyboard:(id)sender
{
//	[firstResponder resignFirstResponder];
//	firstResponder = nil;
}

- (void)nextPrevious:(id)sender
{
//	switch([(UISegmentedControl *)sender selectedSegmentIndex]) {
//		case 0:
//			// previous
//			if (firstResponder == textField1) {
//				[textField3 becomeFirstResponder];
//			} else if (firstResponder == textField2) {
//				[textField1 becomeFirstResponder];
//			} else if (firstResponder == textField3) {
//				[textField2 becomeFirstResponder];
//			}
//			break;
//		case 1:
//			// next
//			if (firstResponder == textField1) {
//				[textField2 becomeFirstResponder];
//			} else if (firstResponder == textField2) {
//				[textField3 becomeFirstResponder];
//			} else if (firstResponder == textField3) {
//				[textField1 becomeFirstResponder];
//			}
//			break;
//	}
	
}

- (void)clickFaceBtn:(id)sender
{
    keyboardShouldChange = FALSE;
    if (showFaceBoard)
    {
        self.textView.inputView = nil;
    }
    else
    {
        self.textView.inputView = _oneFaceBoardView;
        _oneFaceBoardView.inputTextView = self.textView;
    }
    showFaceBoard = !showFaceBoard;
    [self.textView resignFirstResponder];
    
}

- (IBAction)clickRichTextButton:(id)sender
{
    NSLog(@"clickRichText");
    NSString *faceMessage = self.textView.text;
    
    RichTextView *richTextView = [[RichTextView alloc] initWithRichMessage:faceMessage];
    [self.textView addSubview:richTextView];
    
    self.textView.text = @"";
    
    richTextView = nil;
    faceMessage = nil;
}

@end
