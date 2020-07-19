//
//  MyBaseTextLayoutBuilder.h
//  TagLabel
//
//  Created by zhengyi on 2020/7/19.
//  Copyright © 2020 zhengyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyBaseTextLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyBaseTextLayoutBuilder : NSObject

@property (nonatomic, strong, readonly, nullable) MyBaseTextLayout *textLayout;

- (void)appendText:(NSString *)text color:(nullable UIColor *)color font:(nullable UIFont *)font attributes:(nullable NSDictionary *)attributes;

- (void)appendAttributedString:(NSAttributedString *)attrString;

- (void)appendAttachment:(MyBaseAttachment *)attachment;

- (void)addAttribute:(NSAttributedStringKey)name value:(id)value;

- (void)addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range;

- (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;

- (void)removeAttribute:(NSAttributedStringKey)name range:(NSRange)range;

- (nullable MyBaseTextLayout *)buildWithRect:(CGRect)rect;

+ (NSAttributedString *)emptyAttributedStringWithWidth:(CGFloat)width
                                                ascent:(CGFloat)ascent
                                               descent:(CGFloat)descent
                                            attributes:(nullable NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
