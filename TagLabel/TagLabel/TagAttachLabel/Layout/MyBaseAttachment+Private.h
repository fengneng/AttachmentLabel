//
//  MyBaseAttachment+Private.h
//  TagLabel
//
//  Created by zhengyi on 2020/7/19.
//  Copyright © 2020 zhengyi. All rights reserved.
//

#import "MyBaseAttachment.h"

NS_ASSUME_NONNULL_BEGIN

@class MyBaseTextLayout;

@interface MyBaseAttachment ()

@property (nonatomic, assign) CGSize size;
// Cocoa 坐标系
@property (nonatomic, assign) CGRect rect;

@end


@interface MyBaseBorderAttachment ()

// auto calculate when set text
@property (nonatomic, assign, readonly) CGSize headIconSize;
@property (nonatomic, assign, readonly) CGSize textSize;
@property (nonatomic, assign, readonly) CGSize subTextSize;

@property (nonatomic, assign, readonly) CGRect headIconRect;
@property (nonatomic, assign, readonly) CGRect textRect;
@property (nonatomic, assign, readonly) CGRect subTextRect;

@property (nonatomic, strong, readonly) UIImage *image;

@end

NS_ASSUME_NONNULL_END
