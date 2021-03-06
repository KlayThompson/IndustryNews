//
//  MainNewsTableViewCell.m
//  BusinessNews
//
//  Created by KlayThompson on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "MainNewsTableViewCell.h"
#import "SysTools.h"
#import "UIImageView+WebCache.h"

@implementation MainNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.newsTitleLabel.text = @"中国为这一“国之重器”专门成立公司习近平作重要指示中国为这一“国之重器”专门成立公司中国为这一“国之重器”专门成立公司习近平作重要指示习近平作重要指示";
    
    self.newsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.newsImageView.layer.masksToBounds = YES;
}

- (void)configureNewsListCellWithNewsListUnit:(NewsListUnit *)unit {

    if (!unit) {
        return;
    }
    
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:StringObj(unit.imagePic)] placeholderImage:IMG_PLACEHOLDER_PURCHASE_ICON];
    self.newsTitleLabel.text = StringObj(unit.articleName);
    self.readCountLabel.text = StringObj(unit.viewCount);
    self.sourceNewsLabel.text = StringObj(unit.webSitName);
    [self.newsSourceImageView sd_setImageWithURL:[NSURL URLWithString:StringObj(unit.webSitLogo)] placeholderImage:IMG_PLACEHOLDER_PURCHASE_ICON];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
