//
//  ViewController.m
//  TagLabel
//
//  Created by zhengyi on 2020/7/19.
//  Copyright © 2020 zhengyi. All rights reserved.
//

#import "ViewController.h"
//
#import "MyBaseTextLayoutBuilder.h"
#import "MyBaseTextLayout.h"
#import "MyBaseTagLabel.h"

@interface ViewController ()

@property (nonatomic, strong) MyBaseTagLabel *displayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    {
        self.displayView = [MyBaseTagLabel new];
        self.displayView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.displayView];
        
        MyBaseTextLayoutBuilder *builder = [MyBaseTextLayoutBuilder new];
        
        [builder appendAttachment:[self borderAttachment]];
        [builder appendAttachment:[self emptyAttachment]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.lineSpacing = 5;
        paragraphStyle.maximumLineHeight = paragraphStyle.minimumLineHeight = 16;
        NSString *text = @"0-9a-zA-Z @_.-{}[]一二三四五六七八九十，壹，贰，参，肆，伍，陆，柒，捌，玖，拾，壹，贰，参，肆，伍，陆，柒，捌，玖，拾，壹，贰，参，肆，伍，陆，柒，捌，玖，拾，壹，贰，参，肆，伍，陆，柒，捌，玖，拾";
        [builder appendText:text
                      color:[UIColor blackColor]
                       font:[UIFont systemFontOfSize:13]
                 attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
        
        MyBaseTextLayout *textLayout = [builder buildWithRect:CGRectMake(0, 0, 200, MAXFLOAT)];
        self.displayView.frame = CGRectMake(20, 400, ceil(textLayout.rect.size.width), textLayout.rect.size.height);
        [self.displayView setTextLayout:textLayout];
    }
    
}

- (MyBaseBorderAttachment *)borderAttachment {
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"广告" attributes:@{NSForegroundColorAttributeName: [UIColor systemPinkColor], NSFontAttributeName: [UIFont systemFontOfSize:10]}];
    
    MyBaseBorderAttachment * border = [[MyBaseBorderAttachment alloc] initWithText:text subText:nil headIcon:nil offset:CGPointMake(4, 2) minSize:CGSizeMake(16, 16)];
    border.strokeColor = [UIColor systemPinkColor];
    border.strokeWidth = 0.5;
    border.cornerRadius = 2;
    return border;
}

- (MyBaseAttachment *)emptyAttachment {
    static MyBaseAttachment *emptyAttachment = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emptyAttachment = [[MyBaseAttachment alloc] initWithSize:CGSizeMake(3, 1) action:nil];
    });
    return emptyAttachment;
}


@end
