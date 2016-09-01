//
//  SelectIndustryTagView.m
//  BusinessNews
//
//  Created by KlayThompson on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "SelectIndustryTagView.h"


@implementation SelectIndustryTagView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {

    self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
}

- (void)tapClick {

    [self removeFromSuperview];
}

@end
