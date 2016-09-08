//
//  SecondMainNewsCell.h
//  BusinessNews
//
//  Created by liufeng on 16/9/8.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListUnit.h"

@interface SecondMainNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (weak, nonatomic) IBOutlet UIImageView *newsSourceImageView;
@property (weak, nonatomic) IBOutlet UILabel *sourceNewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *readCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *newsTitleToRightConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceNewsLabelToRightConstraints;

- (void)configureNewsListCellWithNewsListUnit:(NewsListUnit *)unit;


@end
