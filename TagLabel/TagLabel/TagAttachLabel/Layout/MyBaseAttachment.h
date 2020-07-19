//
//  MyBaseAttachment.h
//  TagLabel
//
//  Created by zhengyi on 2020/7/19.
//  Copyright © 2020 zhengyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBaseAttachment : NSObject

@property (nonatomic, assign, readonly) CGSize size;
// Cocoa 坐标系
@property (nonatomic, assign, readonly) CGRect rect;

@property (nonatomic, assign) CGFloat descent;

@property (nonatomic, assign) NSUInteger position;

@property (nonatomic, copy, nullable) NSString *action;

- (instancetype)initWithSize:(CGSize)size action:(nullable NSString *)action;

@end

@interface MyBaseImageAttachment : MyBaseAttachment

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSString *URLString;

@end

@interface MyBaseBorderAttachment : MyBaseAttachment

@property (nonatomic, assign) CGFloat strokeWidth;

@property (nonatomic, strong, nullable) UIColor *strokeColor;

@property (nonatomic, strong, nullable) UIColor *fillColor;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign, readonly) CGPoint offset;

@property (nonatomic, copy, readonly, nullable) NSAttributedString *text;
@property (nonatomic, copy, readonly, nullable) NSAttributedString *subText;
@property (nonatomic, strong, readonly, nullable) UIImage *headIcon;

- (instancetype)initWithText:(nullable NSAttributedString *)text
                     subText:(nullable NSAttributedString *)subText
                    headIcon:(nullable UIImage *)headIcon
                      offset:(CGPoint)offset
                     minSize:(CGSize)minSize;

@end

@protocol MyBaseDrawAble <NSObject>

- (void)drawRect:(CGRect)rect;

@end

@interface MyBaseAttachment (Extension) <MyBaseDrawAble>

/**
 转换 Cocoa 坐标 至 CocoaTouch

 @param rect 翻转区域
 @return CocoaTouch 坐标
 */
- (CGRect)transformCoordinateWithRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
