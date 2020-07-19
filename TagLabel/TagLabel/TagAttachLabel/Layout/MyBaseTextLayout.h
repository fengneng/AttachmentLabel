//
//  MyBaseTextLayout.h
//  TagLabel
//
//  Created by zhengyi on 2020/7/19.
//  Copyright © 2020 zhengyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#import "MyBaseAttachment.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const MyBaseAttachmentAttributeName;

@interface MyBaseTextLayout : NSObject

@property (nonatomic, assign, readonly) CTFrameRef ctFrame;

@property (nonatomic, assign, readonly) CGRect rect;

@property (nonatomic, copy, readonly) NSAttributedString *attributedString;

@property (nonatomic, copy, readonly, nullable) NSArray<__kindof MyBaseAttachment *> *attachments;

- (instancetype)initWithAttributedString:(NSAttributedString *)string rect:(CGRect)rect;

@end


@interface MyBaseTextLayout (Event)

- (nullable id)linkValueAtPoint:(CGPoint)point inView:(UIView *)view;

- (nullable __kindof MyBaseAttachment *)attachmentAtPoint:(CGPoint)point inView:(UIView *)view;

@end

@interface MyBaseTextLayout (Draw) <MyBaseDrawAble>

@end

@interface MyBaseTextRunDelegate : NSObject

@property (nonatomic, assign) CGFloat ascent;
@property (nonatomic, assign) CGFloat descent;
@property (nonatomic, assign) CGFloat width;

@property (nullable, nonatomic, copy) NSDictionary *userInfo;

/// Need CFRelease() the return value !!!
- (nullable CTRunDelegateRef)CTRunDelegate CF_RETURNS_RETAINED;

@end

NS_ASSUME_NONNULL_END
