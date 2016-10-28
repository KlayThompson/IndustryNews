//
//  NoDataTipView.m
//  tranb
//
//  Created by liufeng on 16/6/15.
//  Copyright © 2016年 cmf. All rights reserved.
//

#import "NoDataTipView.h"

@implementation NoDataTipView

- (void) awakeFromNib {
    [super awakeFromNib];
    self.tipDetailLabel.font = Font14;
    self.publishButton.titleLabel.font = Font14;
    self.publishButton.layer.cornerRadius = 5;
    self.publishButton.layer.masksToBounds = YES;
}

- (void) setUpTipImageName:(NSString *) imageName tipLabelString:(NSString *)tipLabelString buttonTitleString:(NSString *)buttonTitleString {

    self.tipImageView.image = [UIImage imageNamed:imageName];
    self.tipDetailLabel.text = tipLabelString;
    [self.publishButton setTitle:buttonTitleString forState:UIControlStateNormal];
}
@end
