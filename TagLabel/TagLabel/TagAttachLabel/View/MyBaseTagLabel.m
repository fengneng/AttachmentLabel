//
//  MyBaseDanmakuDisplayView.m
//  BPAttributeView
//
//  Created by zhengyi on 2019/12/14.
//  Copyright © 2019 zhengyi. All rights reserved.
//

#import "MyBaseTagLabel.h"

@implementation MyBaseTagLabel

- (void)setTextLayout:(MyBaseTextLayout *)textLayout {
    if (_textLayout != textLayout) {
        _textLayout = textLayout;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    if (!self.textLayout) return;

    [self.textLayout drawRect:rect];
}


@end
