//
//  MainNewsTableViewCell.h
//  BusinessNews
//
//  Created by KlayThompson on 16/8/31.
//  Copyright © 2016年 KlayThompson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainNewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *newsSourceImageView;

@property (weak, nonatomic) IBOutlet UILabel *sourceNewsLabel;

@property (weak, nonatomic) IBOutlet UILabel *readCountLabel;
@end
