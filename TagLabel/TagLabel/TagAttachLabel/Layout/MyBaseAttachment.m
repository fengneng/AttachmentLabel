//
//  MyBaseAttachment.m
//  TagLabel
//
//  Created by zhengyi on 2020/7/19.
//  Copyright © 2020 zhengyi. All rights reserved.
//

#import "MyBaseAttachment.h"
#import "MyBaseAttachment+Private.h"

#import "MyBaseTextLayout.h"

@implementation MyBaseAttachment

- (instancetype)init {
    return [self initWithSize:CGSizeZero action:nil];
}

- (instancetype)initWithSize:(CGSize)size action:(NSString *)action {
    if (self = [super init]) {
        self.size = size;
        self.action = action;
        self.descent = 3.f;
    }
    return self;
}

@end

@implementation MyBaseImageAttachment

@end

@implementation MyBaseBorderAttachment

- (instancetype)initWithText:(nullable NSAttributedString *)text
                     subText:(nullable NSAttributedString *)subText
                    headIcon:(nullable UIImage *)headIcon
                      offset:(CGPoint)offset
                     minSize:(CGSize)minSize {

    if (self = [super init]) {
        _text = [text copy];
        _subText = [subText copy];
        _headIcon = headIcon;

        _offset = offset;

        CGSize size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);


        _textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _subTextSize = [subText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        CGFloat height = MAX(MAX(_textSize.height, _subTextSize.height) + offset.y * 2, minSize.height);
        _headIconSize = [self imageResize:_headIcon limit:height];
        CGFloat width = _textSize.width + offset.x * 2;
        width = subText ? width + height : width;
        // 加上图片
        width = _headIcon ? (width + _headIconSize.width + _offset.x) : width;
        width = MAX(width, minSize.width);

        self.size = CGSizeMake(width, height);
    }
    return self;
}

- (CGSize)imageResize:(UIImage *)image limit:(CGFloat)limit {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat max = MAX(width, height);
    
    if (max == 0) return CGSizeZero;

    double scale = limit / max;
    return CGSizeMake(width * scale, height * scale);
}

- (void)setRect:(CGRect)rect {
    [super setRect:rect];
    [self _updateHeadIconRect];
    [self _createBorderImage];
}

- (void)_updateHeadIconRect {
    CGRect rect = self.rect;
    if (!self.headIcon) {
        [self _updateTextRect];
    } else {
        CGFloat height = CGRectGetHeight(rect);
        _headIconRect.origin = CGPointMake(_offset.x, (height - self.headIconSize.height)*0.5f);
        _headIconRect.size = self.headIconSize;

        CGFloat x = self.headIconSize.width + _offset.x * 2;
        [self _updateSubTextRectWithOffsetX:x];
    }
}

- (void)_updateTextRect {
    if (!self.subText) {
        _textRect.origin = _offset;
        _textRect.size = self.textSize;
        _subTextRect = CGRectZero;
    } else {
        [self _updateSubTextRectWithOffsetX:_offset.x];
    }
}

- (void)_updateSubTextRectWithOffsetX:(CGFloat)x {
    CGRect rect = self.rect;
    CGFloat height = CGRectGetHeight(rect);
    _textRect.origin.x = x;
    _textRect.origin.y = _offset.y;
    _textRect.size = self.textSize;

    CGFloat subTextWidth = _subTextSize.width;
    CGFloat paddingRight = (height - subTextWidth) * 0.5;

    _subTextRect.origin.x = CGRectGetWidth(rect) - subTextWidth - paddingRight - self.strokeWidth * 0.5;
    _subTextRect.origin.y = _offset.y;
    _subTextRect.size.width = height;
    _subTextRect.size.height = height;
}

- (void)_createBorderImage {

    CGRect imageRect = self.rect;
    imageRect.origin = CGPointZero;

    UIGraphicsBeginImageContextWithOptions(self.rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (!context) return;

    CGFloat lineWidth = self.strokeWidth;
    UIColor *fillColor = self.fillColor ? : [UIColor clearColor];
    UIColor *strokeColor = self.strokeColor ? : [UIColor clearColor];

    // 边框
    [self drawBorderRect:imageRect lineWidth:lineWidth strokeColor:strokeColor fillColor:fillColor];

    // 右边白色底图
    BOOL single = !self.subText;
    if (!single) {
        CGFloat height = CGRectGetHeight(imageRect);

        imageRect.origin.x = CGRectGetMaxX(imageRect) - height - lineWidth;
        imageRect.size.width = height + lineWidth;

        [self drawWhiteRect:imageRect radius:_cornerRadius];
    }

    if (self.headIcon) [self.headIcon drawInRect:self.headIconRect];
    // 文字
    if (self.text) [self.text drawInRect:self.textRect];
    if (self.subText) [self.subText drawInRect:self.subTextRect];

    _image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)drawBorderRect:(CGRect)rect lineWidth:(CGFloat)lineWidth strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor {

    CGContextRef context = UIGraphicsGetCurrentContext();

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
    path.usesEvenOddFillRule = YES;
    [path addClip];

    CGContextAddPath(context, path.CGPath);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawWhiteRect:(CGRect)rect radius:(CGFloat)r {

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);

    CGContextMoveToPoint(context, minX, minY);          // 左上角
    CGContextAddLineToPoint(context, minX, maxY);       // 左下角
    CGContextAddLineToPoint(context, maxX - r, maxY);   // 右下角
    CGContextAddArc(context, maxX - r, maxY - r, r, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, maxX, minY + r);   // 右上角
    CGContextAddArc(context, maxX - r, minY + r, r, 0.0f, -M_PI / 2, 1);
    CGContextAddLineToPoint(context, minX, minY);       // 左上角

    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end

@implementation MyBaseAttachment (Extension)

- (CGRect)transformCoordinateWithRect:(CGRect)rect {
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, CGRectGetHeight(rect));
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    return CGRectApplyAffineTransform(_rect, transform);
}

#pragma mark - MyBaseDrawAble

- (void)drawRect:(CGRect)rect { }

@end

@interface MyBaseImageAttachment (Draw)

@end

@implementation MyBaseImageAttachment (Draw)

- (void)drawRect:(CGRect)rect {
    if (!self.name.length) return;

    UIImage *image = [UIImage imageNamed:self.name];
    if (!image) return;

    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return;

    CGContextDrawImage(context, self.rect, image.CGImage);
}

@end


@interface MyBaseBorderAttachment (Draw)

@end

@implementation MyBaseBorderAttachment (Draw)

- (void)drawRect:(CGRect)rect {

    if (!self.image) return;

    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return;

    CGContextDrawImage(context, self.rect, self.image.CGImage);
}

@end
