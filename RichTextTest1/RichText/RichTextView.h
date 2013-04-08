//
//  RichTextView.h
//  RichTextTest1
//
//  Created by 赵 峰 on 13-4-8.
//  Copyright (c) 2013年 赵 峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RichTextView : UIView

- (id)initWithRichMessage:(NSString *)richMessage;

- (NSArray *)createFaceArray:(NSDictionary *)faceDic;

@end
