//
//  NoDataTipView.h
//  tranb
//
//  Created by liufeng on 16/6/15.
//  Copyright © 2016年 cmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataTipView : UIView

/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
/**提示文字*/
@property (weak, nonatomic) IBOutlet UILabel *tipDetailLabel;
/**发布按钮*/
@property (weak, nonatomic) IBOutlet UIButton *publishButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewToTopSpaceConstant;


//设置提示图片文字按钮
- (void) setUpTipImageName:(NSString *) imageName tipLabelString:(NSString *)tipLabelString buttonTitleString:(NSString *)buttonTitleString;

@end
