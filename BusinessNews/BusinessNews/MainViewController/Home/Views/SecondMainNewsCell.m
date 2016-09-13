//
//  SecondMainNewsCell.m
//  BusinessNews
//
//  Created by liufeng on 16/9/8.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "SecondMainNewsCell.h"
#import "SysTools.h"
#import "UIImageView+WebCache.h"

@implementation SecondMainNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //    self.newsTitleLabel.text = @"中国为这一“国之重器”专门成立公司习近平作重要指示中国为这一“国之重器”专门成立公司中国为这一“国之重器”专门成立公司习近平作重要指示习近平作重要指示";
    
    self.newsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.newsImageView.layer.masksToBounds = YES;
}

- (void)configureNewsListCellWithNewsListUnit:(NewsListUnit *)unit {
    
    if (!unit) {
        return;
    }
    if (STR_IS_NIL(unit.imagePic)) {
        self.newsImageView.hidden = YES;
        self.newsTitleToRightConstraints.constant = 35;
    } else {
        self.newsImageView.hidden = NO;
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:StringObj([unit getSmallImagePicString])] placeholderImage:IMG_PLACEHOLDER_PURCHASE_ICON];
        self.newsTitleToRightConstraints.constant = 120;
    }
    self.newsTitleLabel.text = StringObj(unit.articleName);
    self.readCountLabel.text = StringObj(unit.viewCount);
    self.sourceNewsLabel.text = StringObj(unit.webSitName);
    [self.newsSourceImageView sd_setImageWithURL:[NSURL URLWithString:StringObj(unit.webSitLogo)] placeholderImage:IMG_PLACEHOLDER_PURCHASE_ICON];
//    self.newsTitleLabel.text = @"中国为这一“国之重器”专门成立公司习近平作重要指示中国为这一“国之重器";
}

@end
