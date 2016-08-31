//
//  MainNewsTableViewCell.m
//  BusinessNews
//
//  Created by KlayThompson on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "MainNewsTableViewCell.h"

@implementation MainNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.newsTitleLabel.text = @"中国为这一“国之重器”专门成立公司习近平作重要指示";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
