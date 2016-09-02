//
//  IndustryWebsiteCollectionViewCell.h
//  BusinessNews
//
//  Created by liufeng on 16/9/1.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustryCmd.h"

@interface IndustryWebsiteCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *websiteImageView;

@property (weak, nonatomic) IBOutlet UILabel *websiteTitleLabel;


- (void)configureCellWithIndustryCmd:(WebsitesUnit *)unit;

@end
