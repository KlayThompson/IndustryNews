//
//  DetailViewController.h
//  IndusturyNews
//
//  Created by liufeng on 16/8/24.
//  Copyright © 2016年 liufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

