//
//  IndustryWebsiteCollectionViewCell.m
//  BusinessNews
//
//  Created by liufeng on 16/9/1.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import "IndustryWebsiteCollectionViewCell.h"
#import "SysTools.h"
#import "UIImageView+WebCache.h"

@implementation IndustryWebsiteCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.websiteImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.websiteImageView.layer.masksToBounds = YES;
}

- (void)configureCellWithIndustryCmd:(WebsitesUnit *)unit {

    if (!unit) {
        return;
    }
    
    self.websiteTitleLabel.text = StringObj(unit.websiteName);
    
    [self.websiteImageView sd_setImageWithURL:[NSURL URLWithString:StringObj(unit.websiteLogo)] placeholderImage:IMG_PLACEHOLDER_PURCHASE_ICON];
    
}

@end
